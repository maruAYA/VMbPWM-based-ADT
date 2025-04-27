set_property OUTPUT_VALUE 0 [get_hw_probes glb_rstn -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"glb_rst"}]]
commit_hw_vio [get_hw_probes {glb_rstn} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"glb_rst"}]]
set_property OUTPUT_VALUE 0 [get_hw_probes VbPWM_rstn -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"glb_rst"}]]
commit_hw_vio [get_hw_probes {VbPWM_rstn} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"glb_rst"}]]
set_property OUTPUT_VALUE 1 [get_hw_probes gth_rx_rst -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"glb_rst"}]]
commit_hw_vio [get_hw_probes {gth_rx_rst} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"glb_rst"}]]
set_property OUTPUT_VALUE 1 [get_hw_probes gth_tx_rst -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"glb_rst"}]]
commit_hw_vio [get_hw_probes {gth_tx_rst} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"glb_rst"}]]


set_property OUTPUT_VALUE 1 [get_hw_probes glb_rstn -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"glb_rst"}]]
commit_hw_vio [get_hw_probes {glb_rstn} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"glb_rst"}]]

source E:/ADT/exp_vec_real_script.tcl
source E:/ADT/exp_vec_imag_script.tcl
source E:/ADT/init_len_real_script.tcl
source E:/ADT/init_len_imag_script.tcl

set_property OUTPUT_VALUE 0 [get_hw_probes gth_rx_rst -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"glb_rst"}]]
commit_hw_vio [get_hw_probes {gth_rx_rst} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"glb_rst"}]]
set_property OUTPUT_VALUE 0 [get_hw_probes gth_tx_rst -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"glb_rst"}]]
commit_hw_vio [get_hw_probes {gth_tx_rst} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"glb_rst"}]]
set_property OUTPUT_VALUE 1 [get_hw_probes VbPWM_rstn -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"glb_rst"}]]
commit_hw_vio [get_hw_probes {VbPWM_rstn} -of_objects [get_hw_vios -of_objects [get_hw_devices xczu9_0] -filter {CELL_NAME=~"glb_rst"}]]