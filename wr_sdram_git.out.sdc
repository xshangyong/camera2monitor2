## Generated SDC file "wr_sdram_git.out.sdc"

## Copyright (C) 1991-2011 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 11.0 Build 208 07/03/2011 Service Pack 1 SJ Full Version"

## DATE    "Tue Apr 19 22:19:08 2016"

##
## DEVICE  "EP4CE15F17C8"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk_in} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLK}]
create_clock -name {pclk} -period 21.920 -waveform { 0.000 10.960 } [get_ports {cmos_pclk}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {clk100} -source [get_pins {inst_133m|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 2 -divide_by 5 -master_clock {inst_100m|altpll_component|auto_generated|pll1|clk[0]} [get_pins {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {clk133} -source [get_pins {inst_133m|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 1 -master_clock {inst_100m|altpll_component|auto_generated|pll1|clk[0]} [get_pins {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] 
create_generated_clock -name {inst_100m|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {inst_100m|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 2 -master_clock {clk_in} [get_pins {inst_100m|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {inst_100m|altpll_component|auto_generated|pll1|clk[1]} -source [get_pins {inst_100m|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 12 -divide_by 25 -master_clock {clk_in} [get_pins {inst_100m|altpll_component|auto_generated|pll1|clk[1]}] 
create_generated_clock -name {inst_100m|altpll_component|auto_generated|pll1|clk[2]} -source [get_pins {inst_100m|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 1 -divide_by 2 -master_clock {clk_in} [get_pins {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {clk_in}] -rise_to [get_clocks {clk_in}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {clk_in}] -fall_to [get_clocks {clk_in}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {clk_in}] -rise_to [get_clocks {clk_in}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {clk_in}] -fall_to [get_clocks {clk_in}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {pclk}] -rise_to [get_clocks {pclk}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {pclk}] -fall_to [get_clocks {pclk}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {pclk}] -rise_to [get_clocks {pclk}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {pclk}] -fall_to [get_clocks {pclk}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}]  0.020 


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock [get_clocks {pclk}]  0.000 [get_ports {cmos_data[0]}]
set_input_delay -add_delay  -clock [get_clocks {pclk}]  0.000 [get_ports {cmos_data[1]}]
set_input_delay -add_delay  -clock [get_clocks {pclk}]  0.000 [get_ports {cmos_data[2]}]
set_input_delay -add_delay  -clock [get_clocks {pclk}]  0.000 [get_ports {cmos_data[3]}]
set_input_delay -add_delay  -clock [get_clocks {pclk}]  0.000 [get_ports {cmos_data[4]}]
set_input_delay -add_delay  -clock [get_clocks {pclk}]  0.000 [get_ports {cmos_data[5]}]
set_input_delay -add_delay  -clock [get_clocks {pclk}]  0.000 [get_ports {cmos_data[6]}]
set_input_delay -add_delay  -clock [get_clocks {pclk}]  0.000 [get_ports {cmos_data[7]}]


#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************

set_false_path  -from  [get_clocks {pclk}]  -to  [get_clocks {clk133}]
set_false_path  -from  [get_clocks {clk133}]  -to  [get_clocks {pclk}]
set_false_path  -from  [get_clocks {clk100}]  -to  [get_clocks {clk_in}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_te9:dffpipe9|dffe10a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_se9:dffpipe6|dffe7a*}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

