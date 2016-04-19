read_sdc "wr_sdram_git2.out.sdc"

#set all sdram port 0 output delay
set_output_delay -clock { clk133 } 0 [get_ports {sdram_nwe sdram_addr[0] sdram_addr[1] sdram_addr[2] sdram_addr[3] sdram_addr[4] sdram_addr[5] sdram_addr[6] sdram_addr[7] sdram_addr[8] sdram_addr[9] sdram_addr[10] sdram_addr[11] sdram_addr[12] sdram_ba[0] sdram_ba[1] sdram_clk sdram_clke sdram_data[0] sdram_data[1] sdram_data[2] sdram_data[3] sdram_data[4] sdram_data[5] sdram_data[6] sdram_data[7] sdram_data[8] sdram_data[9] sdram_data[10] sdram_data[11] sdram_data[12] sdram_data[13] sdram_data[14] sdram_data[15] sdram_dqm[0] sdram_dqm[1] sdram_ncas sdram_ncs sdram_nras}]

report_timing -to [get_ports {sdram_data[0] sdram_data[1] sdram_data[2] sdram_data[3] sdram_data[4] sdram_data[5] sdram_data[6] sdram_data[7] sdram_data[8] sdram_data[9] sdram_data[10] sdram_data[11] sdram_data[12] sdram_data[13] sdram_data[14] sdram_data[15]}] -setup -npaths 1 -detail full_path -panel_name {Report Timing} -file "C:/FPGA/fpga_proj/camera2monitor2/STA/sdram_data_outputdelay.txt"

report_timing -to [get_ports {sdram_data[0] sdram_data[1] sdram_data[2] sdram_data[3] sdram_data[4] sdram_data[5] sdram_data[6] sdram_data[7] sdram_data[8] sdram_data[9] sdram_data[10] sdram_data[11] sdram_data[12] sdram_data[13] sdram_data[14] sdram_data[15]}] -hold -npaths 1 -detail full_path -panel_name {Report Timing} -file "C:/FPGA/fpga_proj/camera2monitor2/STA/sdram_data_outputdelay.txt" -append

report_timing -to [get_ports {sdram_clk}] -setup -npaths 1 -detail full_path -panel_name {Report Timing} -file "C:/FPGA/fpga_proj/camera2monitor2/STA/sdram_clk_outputdelay.txt"

report_timing -to [get_ports {sdram_clk}] -hold -npaths 1 -detail full_path -panel_name {Report Timing} -file "C:/FPGA/fpga_proj/camera2monitor2/STA/sdram_clk_outputdelay.txt" -append

report_timing -to [get_ports {sdram_addr[0] sdram_addr[1] sdram_addr[2] sdram_addr[3] sdram_addr[4] sdram_addr[5] sdram_addr[6] sdram_addr[7] sdram_addr[8] sdram_addr[9] sdram_addr[10] sdram_addr[11] sdram_addr[12]}] -setup -npaths 1 -detail full_path -panel_name {Report Timing} -file "C:/FPGA/fpga_proj/camera2monitor2/STA/sdram_add_outputdelay.txt"

report_timing -to [get_ports {sdram_addr[0] sdram_addr[1] sdram_addr[2] sdram_addr[3] sdram_addr[4] sdram_addr[5] sdram_addr[6] sdram_addr[7] sdram_addr[8] sdram_addr[9] sdram_addr[10] sdram_addr[11] sdram_addr[12]}] -hold -npaths 1 -detail full_path -panel_name {Report Timing} -file "C:/FPGA/fpga_proj/camera2monitor2/STA/sdram_add_outputdelay.txt" -append

report_timing -to [get_ports {sdram_ncas}] -setup -npaths 1 -detail full_path -panel_name {Report Timing} -file "C:/FPGA/fpga_proj/camera2monitor2/STA/sdram_cmd_outputdelay.txt"

report_timing -to [get_ports {sdram_ncas}] -hold -npaths 1 -detail full_path -panel_name {Report Timing} -file "C:/FPGA/fpga_proj/camera2monitor2/STA/sdram_cmd_outputdelay.txt" -append

report_timing -to [get_ports {sdram_ncs}] -setup -npaths 1 -detail full_path -panel_name {Report Timing} -file "C:/FPGA/fpga_proj/camera2monitor2/STA/sdram_cmd_outputdelay.txt" -append

report_timing -to [get_ports {sdram_ncs}] -hold -npaths 1 -detail full_path -panel_name {Report Timing} -file "C:/FPGA/fpga_proj/camera2monitor2/STA/sdram_cmd_outputdelay.txt" -append

report_timing -to [get_ports {sdram_nras}] -setup -npaths 1 -detail full_path -panel_name {Report Timing} -file "C:/FPGA/fpga_proj/camera2monitor2/STA/sdram_cmd_outputdelay.txt" -append

report_timing -to [get_ports {sdram_nras}] -hold -npaths 1 -detail full_path -panel_name {Report Timing} -file "C:/FPGA/fpga_proj/camera2monitor2/STA/sdram_cmd_outputdelay.txt" -append

report_timing -to [get_ports {sdram_nwe}] -setup -npaths 1 -detail full_path -panel_name {Report Timing} -file "C:/FPGA/fpga_proj/camera2monitor2/STA/sdram_cmd_outputdelay.txt" -append

report_timing -to [get_ports {sdram_nwe}] -hold -npaths 1 -detail full_path -panel_name {Report Timing} -file "C:/FPGA/fpga_proj/camera2monitor2/STA/sdram_cmd_outputdelay.txt" -append



