set_output_delay -clock { inst_133m|altpll_component|auto_generated|pll1|clk[0] } -max 0 [get_ports {sclk}]
report_timing -to [get_ports {sclk}] -setup -npaths 1 -detail full_path -panel_name {Report Timing} -file "C:/FPGA/fpga_proj/camera2monitor2/STA/sda_sclk_timing.txt"

set_output_delay -clock { inst_133m|altpll_component|auto_generated|pll1|clk[0] } -max 0 [get_ports {sda}]
report_timing -to [get_ports {sda}] -setup -npaths 1 -detail full_path -panel_name {Report Timing} -file "C:/FPGA/fpga_proj/camera2monitor2/STA/sda_sclk_timing.txt"
