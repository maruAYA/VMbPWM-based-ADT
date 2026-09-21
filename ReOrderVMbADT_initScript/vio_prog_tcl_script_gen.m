clear;
close all;
fc = 0.75e9;
fs = 16e9;
N=64;
index(1:N) = 0:1:N-1;
is_Reorder = 1;

if is_Reorder == 1
    if fc > fs/4
        fc = fs/2-fc;
        polar_vec = repmat([0,1],[1,N/2]);
        exp_vec = (1/N*exp(1i*2*pi*fc*index/fs));
        exp_vec_mat = [angle(exp_vec);index];
        exp_vec_sort = sortrows(exp_vec_mat',"ascend");
        % exp_vec = (1/N*exp(-1i*2*pi*fc*exp_vec_sort(:,2)'/fs));
        sorted_index = exp_vec_sort(:,2)';
        sorted_index_fold = [sorted_index(1:2:end),sorted_index(2:2:end)];
        f_c_s = fc / fs;
        exp_vec = round((2^15-1) * cos(2 * pi * (f_c_s * sorted_index_fold)) / N)+1i * round((2^15-1) * sin(2 * pi * (f_c_s * sorted_index_fold))/N);
        polar_vec_int = bit2int(uint8(flip(polar_vec')),N);
    else
        fc = fc;
        polar_vec = zeros(1,N);
        exp_vec = (1/N*exp(-1i*2*pi*fc*index/fs));
        exp_vec_mat = [angle(exp_vec);index];
        exp_vec_sort = sortrows(exp_vec_mat',"descend");
        % exp_vec = (1/N*exp(-1i*2*pi*fc*exp_vec_sort(:,2)'/fs));
        sorted_index = exp_vec_sort(:,2)';
        sorted_index_fold = [sorted_index(1:2:end),sorted_index(2:2:end)];
        f_c_s = fc / fs;
        exp_vec = round((2^15-1) * cos(-2 * pi * (f_c_s * sorted_index_fold)) / N)+1i * round((2^15-1) * sin(-2 * pi * (f_c_s * sorted_index_fold))/N);
        polar_vec_int = bit2int(uint8(flip(polar_vec')),N);
    end
else
    polar_vec = zeros(1,N);
    exp_vec = round((2^15-1) * cos(-2 * pi * (f_c_s * index)) / N)+1i * round((2^15-1) * sin(-2 * pi * (f_c_s * index))/N);
    sorted_index_fold = index;
    polar_vec_int = bit2int(uint8(flip(polar_vec')),N);
end
vec_index = sorted_index_fold;

exp_vec_real = int16(real(exp_vec));
exp_vec_imag = int16(imag(exp_vec));
exp_vec_real_hex = dec2hex(exp_vec_real, 4);
exp_vec_imag_hex = dec2hex(exp_vec_imag, 4);
sorted_index_hex = dec2hex(flip(uint8(vec_index)),4);
polar_vec_hex = dec2hex((polar_vec_int),16);

exp_vec_real_filename = 'D:\ADT\2025_1210_ReOrderVbMbPWM_5M\exp_vec_real_script.tcl';
exp_vec_real_fp = fopen(exp_vec_real_filename, 'w');

exp_vec_imag_filename = 'D:\ADT\2025_1210_ReOrderVbMbPWM_5M\exp_vec_imag_script.tcl';
exp_vec_imag_fp = fopen(exp_vec_imag_filename, 'w');

reOrder_vec_filename = 'D:\ADT\2025_1210_ReOrderVbMbPWM_5M\reOrder_vec_script.tcl';
reOrder_vec_fp = fopen(reOrder_vec_filename, 'w');

fprintf(exp_vec_real_fp,'set_property OUTPUT_VALUE 0 [get_hw_probes u_vio_regmap/i_vio_expVecRealEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecReal"}]]\r\n');
fprintf(exp_vec_real_fp,'commit_hw_vio [get_hw_probes {u_vio_regmap/i_vio_expVecRealEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecReal"}]]\r\n');
fprintf(exp_vec_imag_fp,'set_property OUTPUT_VALUE 0 [get_hw_probes u_vio_regmap/i_vio_expVecImagEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecImag"}]]\r\n');
fprintf(exp_vec_imag_fp,'commit_hw_vio [get_hw_probes {u_vio_regmap/i_vio_expVecImagEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecImag"}]]\r\n');
fprintf(reOrder_vec_fp,'set_property OUTPUT_VALUE 0 [get_hw_probes u_vio_regmap/i_vio_reOrderVecEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_reOrderVec"}]]\r\n');
fprintf(reOrder_vec_fp,'commit_hw_vio [get_hw_probes {u_vio_regmap/i_vio_reOrderVecEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_reOrderVec"}]]\r\n');


for index = 1:1:64
fprintf(exp_vec_real_fp,'set_property OUTPUT_VALUE %s [get_hw_probes u_vio_regmap/i_vio_expVecRealAddr -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecReal"}]]\r\n', dec2hex(index-1,2));
fprintf(exp_vec_real_fp,'commit_hw_vio [get_hw_probes {u_vio_regmap/i_vio_expVecRealAddr} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecReal"}]]\r\n');
fprintf(exp_vec_real_fp,'set_property OUTPUT_VALUE %s [get_hw_probes u_vio_regmap/i_vio_expVecReal -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecReal"}]]\r\n', exp_vec_real_hex(index,:));
fprintf(exp_vec_real_fp,'commit_hw_vio [get_hw_probes {u_vio_regmap/i_vio_expVecReal} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecReal"}]]\r\n');
fprintf(exp_vec_real_fp,'set_property OUTPUT_VALUE 1 [get_hw_probes u_vio_regmap/i_vio_expVecRealEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecReal"}]]\r\n');
fprintf(exp_vec_real_fp,'commit_hw_vio [get_hw_probes {u_vio_regmap/i_vio_expVecRealEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecReal"}]]\r\n');
fprintf(exp_vec_real_fp,'set_property OUTPUT_VALUE 0 [get_hw_probes u_vio_regmap/i_vio_expVecRealEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecReal"}]]\r\n');
fprintf(exp_vec_real_fp,'commit_hw_vio [get_hw_probes {u_vio_regmap/i_vio_expVecRealEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecReal"}]]\r\n');

fprintf(exp_vec_imag_fp,'set_property OUTPUT_VALUE %s [get_hw_probes u_vio_regmap/i_vio_expVecImagAddr -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecImag"}]]\r\n', dec2hex(index-1,2));
fprintf(exp_vec_imag_fp,'commit_hw_vio [get_hw_probes {u_vio_regmap/i_vio_expVecImagAddr} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecImag"}]]\r\n');
fprintf(exp_vec_imag_fp,'set_property OUTPUT_VALUE %s [get_hw_probes u_vio_regmap/i_vio_expVecImag -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecImag"}]]\r\n', exp_vec_imag_hex(index,:));
fprintf(exp_vec_imag_fp,'commit_hw_vio [get_hw_probes {u_vio_regmap/i_vio_expVecImag} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecImag"}]]\r\n');
fprintf(exp_vec_imag_fp,'set_property OUTPUT_VALUE 1 [get_hw_probes u_vio_regmap/i_vio_expVecImagEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecImag"}]]\r\n');
fprintf(exp_vec_imag_fp,'commit_hw_vio [get_hw_probes {u_vio_regmap/i_vio_expVecImagEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecImag"}]]\r\n');
fprintf(exp_vec_imag_fp,'set_property OUTPUT_VALUE 0 [get_hw_probes u_vio_regmap/i_vio_expVecImagEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecImag"}]]\r\n');
fprintf(exp_vec_imag_fp,'commit_hw_vio [get_hw_probes {u_vio_regmap/i_vio_expVecImagEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_expVecImag"}]]\r\n');

fprintf(reOrder_vec_fp,'set_property OUTPUT_VALUE %s [get_hw_probes u_vio_regmap/i_vio_reOrderVecAddr -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_reOrderVec"}]]\r\n', dec2hex(index-1,2));
fprintf(reOrder_vec_fp,'commit_hw_vio [get_hw_probes {u_vio_regmap/i_vio_reOrderVecAddr} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_reOrderVec"}]]\r\n');
fprintf(reOrder_vec_fp,'set_property OUTPUT_VALUE %s [get_hw_probes u_vio_regmap/i_vio_reOrderVec -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_reOrderVec"}]]\r\n', sorted_index_hex(index,:));
fprintf(reOrder_vec_fp,'commit_hw_vio [get_hw_probes {u_vio_regmap/i_vio_reOrderVec} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_reOrderVec"}]]\r\n');
fprintf(reOrder_vec_fp,'set_property OUTPUT_VALUE 1 [get_hw_probes u_vio_regmap/i_vio_reOrderVecEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_reOrderVec"}]]\r\n');
fprintf(reOrder_vec_fp,'commit_hw_vio [get_hw_probes {u_vio_regmap/i_vio_reOrderVecEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_reOrderVec"}]]\r\n');
fprintf(reOrder_vec_fp,'set_property OUTPUT_VALUE 0 [get_hw_probes u_vio_regmap/i_vio_reOrderVecEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_reOrderVec"}]]\r\n');
fprintf(reOrder_vec_fp,'commit_hw_vio [get_hw_probes {u_vio_regmap/i_vio_reOrderVecEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_reOrderVec"}]]\r\n');
end
fprintf(reOrder_vec_fp,'set_property OUTPUT_VALUE %s [get_hw_probes u_vio_regmap/o_polar_vec -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_polarvec"}]]\r\n', polar_vec_hex);
fprintf(reOrder_vec_fp,'commit_hw_vio [get_hw_probes {u_vio_regmap/o_polar_vec} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_vio_regmap/u_ip_vio_polarvec"}]]\r\n');

fclose(exp_vec_real_fp);
fclose(exp_vec_imag_fp);
fclose(reOrder_vec_fp);
