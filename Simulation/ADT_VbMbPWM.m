clear;
close all;
parpool(8);
% load('FIR_p015_s020.mat')
% Parameter initialization
f_s = 16e9;

N = 64;

f_BB = 25e6; %Baseband data rate


M = 64;%16QAM

alpha = 0.5;


T = 4e-4;

r = 0.62; %->scaling value, need to be verified for the optimal performance

% RCOS gen


% Waveform gen

t = 0:1/f_BB:T-1/f_BB;
INFO_bit = rand(length(t) * log2(M),1) < 0.5;
INFO_int = bit2int(INFO_bit,log2(M));
INFO_sym = qammod(INFO_int,M,"bin");

INFO_sym = INFO_sym / (max(abs(INFO_sym)));

% Upsample

IF_interp_factor = f_s / N / f_BB;
f_IF = f_s / N;

rcos_filt = rcosdesign(alpha,32, IF_interp_factor);
% rcos_filt = Num;
BB_sym = conv(upsample(INFO_sym, IF_interp_factor), rcos_filt);

BB_sym_norm = BB_sym / (max(abs(BB_sym)));

IF_sym_norm = BB_sym_norm;

t_IF = 0:1/f_IF:(length(IF_sym_norm)-1)/f_IF;
fc_index = 1;

rms_EVM_org = zeros(1,15);
rms_EVM_fire = zeros(1,15);
org_SNR = zeros(1,15);
fire_SNR = zeros(1,15);
for f_c = 0.5e9:0.125e9:7.5e9
IF_sym_phaseCorr = IF_sym_norm .* exp(-1i*2*pi * f_c * t_IF)';
lab_seg_len = floor(length(IF_sym_phaseCorr) / 8);
spmd
    current_lab = spmdIndex();
    for current_index = 1:1:lab_seg_len
        f_c_in = f_c / 1e6;
        f_s_in = f_s / 1e6;
        s = r .* IF_sym_phaseCorr(current_index + (current_lab-1) * lab_seg_len);
        % [out_org,~]=VbMbPWM_228_mex(s,N,f_c,f_s);
        [out_org,~]=VbMbPWM_mex(s,N,f_c,f_s,8);
        target_path_org((current_index-1)*N+1:current_index*N) = double(out_org);
    end
end
RF_bin_org = [cell2mat(target_path_org(1)),cell2mat(target_path_org(2)),...
    cell2mat(target_path_org(3)),cell2mat(target_path_org(4)),...
    cell2mat(target_path_org(5)),cell2mat(target_path_org(6)),...
    cell2mat(target_path_org(7)),cell2mat(target_path_org(8)),];

t_RF = 0:1/f_s:length(RF_bin_org)*1/f_s-1/f_s;
rx_carrier = exp(-1i * 2 * pi * f_c * t_RF)/N;
rx_RF_sym = (2*RF_bin_org - 1) .* rx_carrier;

rx_RF_reshape = reshape(rx_RF_sym,[N,length(rx_RF_sym)/N]);
rx_IF_sym = sum(rx_RF_reshape);
% rx_IF_filt = conv(rx_IF_sym, Num);
rx_INFO_filt = conv(rx_IF_sym, rcos_filt);
rx_INFO_sym = downsample(rx_INFO_filt(length(rcos_filt):end-length(rcos_filt)+1), IF_interp_factor);
power_rx = sum(abs(rx_INFO_sym) .^2);
power_tx = sum(abs(INFO_sym) .^2);
rx_scale = power_tx / power_rx;
rx_INFO_sym_norm = rx_INFO_sym .*sqrt(rx_scale);

mEVM_org = abs(conj(INFO_sym)' - rx_INFO_sym_norm) ./ abs(INFO_sym') * 100; 
rms_EVM_org(fc_index) = sqrt(sum(mEVM_org .^ 2) / length(mEVM_org));

disp('Current fc is ')
disp(f_c)
disp('Current EVM is ')
disp(rms_EVM_org(fc_index))
fc_index = fc_index + 1;

end
delete(gcp('nocreate'));