set_input_delay -clock { pclk } 0 [get_ports {cmos_data[0] cmos_data[1] cmos_data[2] cmos_data[3] cmos_data[4] cmos_data[5] cmos_data[6] cmos_data[7]}]
report_timing -from_clock { pclk } -to_clock { pclk } -from [get_ports {cmos_data[7] cmos_data[0] cmos_data[1] cmos_data[2] cmos_data[3] cmos_data[4] cmos_data[5] cmos_data[6]}] -setup -npaths 1 -detail full_path -panel_name {Report Timing}
report_timing -from_clock { pclk } -to_clock { pclk } -from [get_ports {cmos_data[0] cmos_data[1] cmos_data[2] cmos_data[3] cmos_data[4] cmos_data[5] cmos_data[6] cmos_data[7]}] -hold -npaths 1 -detail full_path -panel_name {Report Timing}


