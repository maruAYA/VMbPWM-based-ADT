clear;
close all;
fc = 7.5e9;
fs = 16e9;
N=64;
f_c_s = fc / fs;
vec_index(1:N) = 0:1:N-1;
exp_vec = round(2^11 * cos(-2 * pi * (f_c_s * vec_index)) / N)+1i * round(2^11 * sin(-2 * pi * (f_c_s * vec_index))/N);
exp_vec_real = int16(real(exp_vec));
exp_vec_imag = int16(imag(exp_vec));
exp_vec_real_hex = dec2hex(exp_vec_real, 3);
exp_vec_imag_hex = dec2hex(exp_vec_imag, 3);

exp_vec_real_filename = 'E:\ADT\VbMbADT\VMbPWM-ADT\VbADT_initScript\exp_vec_real_script.tcl';
exp_vec_real_fp = fopen(exp_vec_real_filename, 'w');

exp_vec_imag_filename = 'E:\ADT\VbMbADT\VMbPWM-ADT\VbADT_initScript\exp_vec_imag_script.tcl';
exp_vec_imag_fp = fopen(exp_vec_imag_filename, 'w');

fprintf(exp_vec_real_fp,'set_property OUTPUT_VALUE 0 [get_hw_probes i_vio_expVecRealEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecReal"}]]\r\n');
fprintf(exp_vec_real_fp,'commit_hw_vio [get_hw_probes {i_vio_expVecRealEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecReal"}]]\r\n');
fprintf(exp_vec_imag_fp,'set_property OUTPUT_VALUE 0 [get_hw_probes i_vio_expVecImagEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecImag"}]]\r\n');
fprintf(exp_vec_imag_fp,'commit_hw_vio [get_hw_probes {i_vio_expVecImagEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecImag"}]]\r\n');

for index = 1:1:64
fprintf(exp_vec_real_fp,'set_property OUTPUT_VALUE %s [get_hw_probes i_vio_expVecRealAddr -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecReal"}]]\r\n', dec2hex(index-1,2));
fprintf(exp_vec_real_fp,'commit_hw_vio [get_hw_probes {i_vio_expVecRealAddr} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecReal"}]]\r\n');
fprintf(exp_vec_real_fp,'set_property OUTPUT_VALUE %s [get_hw_probes i_vio_expVecReal -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecReal"}]]\r\n', exp_vec_real_hex(index,:));
fprintf(exp_vec_real_fp,'commit_hw_vio [get_hw_probes {i_vio_expVecReal} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecReal"}]]\r\n');
fprintf(exp_vec_real_fp,'set_property OUTPUT_VALUE 1 [get_hw_probes i_vio_expVecRealEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecReal"}]]\r\n');
fprintf(exp_vec_real_fp,'commit_hw_vio [get_hw_probes {i_vio_expVecRealEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecReal"}]]\r\n');
fprintf(exp_vec_real_fp,'set_property OUTPUT_VALUE 0 [get_hw_probes i_vio_expVecRealEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecReal"}]]\r\n');
fprintf(exp_vec_real_fp,'commit_hw_vio [get_hw_probes {i_vio_expVecRealEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecReal"}]]\r\n');

fprintf(exp_vec_imag_fp,'set_property OUTPUT_VALUE %s [get_hw_probes i_vio_expVecImagAddr -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecImag"}]]\r\n', dec2hex(index-1,2));
fprintf(exp_vec_imag_fp,'commit_hw_vio [get_hw_probes {i_vio_expVecImagAddr} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecImag"}]]\r\n');
fprintf(exp_vec_imag_fp,'set_property OUTPUT_VALUE %s [get_hw_probes i_vio_expVecImag -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecImag"}]]\r\n', exp_vec_imag_hex(index,:));
fprintf(exp_vec_imag_fp,'commit_hw_vio [get_hw_probes {i_vio_expVecImag} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecImag"}]]\r\n');
fprintf(exp_vec_imag_fp,'set_property OUTPUT_VALUE 1 [get_hw_probes i_vio_expVecImagEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecImag"}]]\r\n');
fprintf(exp_vec_imag_fp,'commit_hw_vio [get_hw_probes {i_vio_expVecImagEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecImag"}]]\r\n');
fprintf(exp_vec_imag_fp,'set_property OUTPUT_VALUE 0 [get_hw_probes i_vio_expVecImagEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecImag"}]]\r\n');
fprintf(exp_vec_imag_fp,'commit_hw_vio [get_hw_probes {i_vio_expVecImagEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_expVecImag"}]]\r\n');
end

node_minus_real_filename = 'E:\ADT\VbMbADT\VMbPWM-ADT\VbADT_initScript\init_len_real_script.tcl';
node_minus_real_fp = fopen(node_minus_real_filename, 'w');

node_minus_imag_filename = 'E:\ADT\VbMbADT\VMbPWM-ADT\VbADT_initScript\init_len_imag_script.tcl';
node_minus_imag_fp = fopen(node_minus_imag_filename, 'w');

node_minus_real(1) = -exp_vec_real(1)-exp_vec_real(2);
node_minus_real(2) = -exp_vec_real(1)+exp_vec_real(2);
node_minus_real(3) = exp_vec_real(1)-exp_vec_real(2);
node_minus_real(4) = exp_vec_real(1)+exp_vec_real(2);

node_minus_real_hex = dec2hex(node_minus_real,3);

node_minus_imag(1) = -exp_vec_imag(1)-exp_vec_imag(2);
node_minus_imag(2) = -exp_vec_imag(1)+exp_vec_imag(2);
node_minus_imag(3) = exp_vec_imag(1)-exp_vec_imag(2);
node_minus_imag(4) = exp_vec_imag(1)+exp_vec_imag(2);

node_minus_imag_hex = dec2hex(node_minus_imag,3);


fprintf(node_minus_real_fp,'set_property OUTPUT_VALUE 0 [get_hw_probes i_vio_nodeLenRealEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenReal"}]]\r\n');
fprintf(node_minus_real_fp,'commit_hw_vio [get_hw_probes {i_vio_nodeLenRealEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenReal"}]]\r\n');
fprintf(node_minus_imag_fp,'set_property OUTPUT_VALUE 0 [get_hw_probes i_vio_nodeLenImagEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenImag"}]]\r\n');
fprintf(node_minus_imag_fp,'commit_hw_vio [get_hw_probes {i_vio_nodeLenImagEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenImag"}]]\r\n');

for index = 1:1:4
fprintf(node_minus_real_fp,'set_property OUTPUT_VALUE %s [get_hw_probes i_vio_nodeLenRealAddr -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenReal"}]]\r\n', dec2hex(index-1,1));
fprintf(node_minus_real_fp,'commit_hw_vio [get_hw_probes {i_vio_nodeLenRealAddr} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenReal"}]]\r\n');
fprintf(node_minus_real_fp,'set_property OUTPUT_VALUE %s [get_hw_probes i_vio_nodeLenReal -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenReal"}]]\r\n', node_minus_real_hex(index,:));
fprintf(node_minus_real_fp,'commit_hw_vio [get_hw_probes {i_vio_nodeLenReal} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenReal"}]]\r\n');
fprintf(node_minus_real_fp,'set_property OUTPUT_VALUE 1 [get_hw_probes i_vio_nodeLenRealEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenReal"}]]\r\n');
fprintf(node_minus_real_fp,'commit_hw_vio [get_hw_probes {i_vio_nodeLenRealEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenReal"}]]\r\n');
fprintf(node_minus_real_fp,'set_property OUTPUT_VALUE 0 [get_hw_probes i_vio_nodeLenRealEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenReal"}]]\r\n');
fprintf(node_minus_real_fp,'commit_hw_vio [get_hw_probes {i_vio_nodeLenRealEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenReal"}]]\r\n');

fprintf(node_minus_imag_fp,'set_property OUTPUT_VALUE %s [get_hw_probes i_vio_nodeLenImagAddr -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenImag"}]]\r\n', dec2hex(index-1,1));
fprintf(node_minus_imag_fp,'commit_hw_vio [get_hw_probes {i_vio_nodeLenImagAddr} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenImag"}]]\r\n');
fprintf(node_minus_imag_fp,'set_property OUTPUT_VALUE %s [get_hw_probes i_vio_nodeLenImag -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenImag"}]]\r\n', node_minus_imag_hex(index,:));
fprintf(node_minus_imag_fp,'commit_hw_vio [get_hw_probes {i_vio_nodeLenImag} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenImag"}]]\r\n');
fprintf(node_minus_imag_fp,'set_property OUTPUT_VALUE 1 [get_hw_probes i_vio_nodeLenImagEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenImag"}]]\r\n');
fprintf(node_minus_imag_fp,'commit_hw_vio [get_hw_probes {i_vio_nodeLenImagEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenImag"}]]\r\n');
fprintf(node_minus_imag_fp,'set_property OUTPUT_VALUE 0 [get_hw_probes i_vio_nodeLenImagEN -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenImag"}]]\r\n');
fprintf(node_minus_imag_fp,'commit_hw_vio [get_hw_probes {i_vio_nodeLenImagEN} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"u_ip_vio_nodeLenImag"}]]\r\n');
end

fclose(exp_vec_real_fp);
fclose(exp_vec_imag_fp);
fclose(node_minus_real_fp);
fclose(node_minus_imag_fp);


