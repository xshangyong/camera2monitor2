## Generated SDC file "wr_sdram_git2.out.sdc"

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

## DATE    "Mon Apr 18 21:17:42 2016"

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

create_clock -name {CLK} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLK}]
create_clock -name {cmos_pclk} -period 1.000 -waveform { 0.000 0.500 } [get_ports {cmos_pclk}]
create_clock -name {camera_cfg:inst_camcfg|clock_20k} -period 1.000 -waveform { 0.000 0.500 } [get_registers {camera_cfg:inst_camcfg|clock_20k}]
create_clock -name {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]} -period 1.000 -waveform { 0.000 0.500 } [get_registers {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}]
create_clock -name {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]} -period 1.000 -waveform { 0.000 0.500 } [get_registers {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {inst_133m|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {inst_133m|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 2 -divide_by 5 -master_clock {inst_100m|altpll_component|auto_generated|pll1|clk[0]} [get_pins {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {inst_133m|altpll_component|auto_generated|pll1|clk[1]} -source [get_pins {inst_133m|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 1 -master_clock {inst_100m|altpll_component|auto_generated|pll1|clk[0]} [get_pins {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] 
create_generated_clock -name {inst_100m|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {inst_100m|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 2 -master_clock {CLK} [get_pins {inst_100m|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {inst_100m|altpll_component|auto_generated|pll1|clk[1]} -source [get_pins {inst_100m|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 12 -divide_by 25 -master_clock {CLK} [get_pins {inst_100m|altpll_component|auto_generated|pll1|clk[1]}] 
create_generated_clock -name {inst_100m|altpll_component|auto_generated|pll1|clk[2]} -source [get_pins {inst_100m|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 1 -divide_by 2 -master_clock {CLK} [get_pins {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {CLK}] -setup 0.140 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {CLK}] -hold 0.100 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {CLK}] -setup 0.140 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {CLK}] -hold 0.100 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -setup 0.130 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -hold 0.100 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -setup 0.130 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -hold 0.100 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {CLK}] -setup 0.140 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {CLK}] -hold 0.100 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {CLK}] -setup 0.140 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {CLK}] -hold 0.100 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -setup 0.130 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -hold 0.100 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -setup 0.130 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -hold 0.100 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {CLK}] -setup 0.140 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {CLK}] -hold 0.100 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {CLK}] -setup 0.140 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {CLK}] -hold 0.100 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {cmos_pclk}] -setup 0.150 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {cmos_pclk}] -hold 0.110 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {cmos_pclk}] -setup 0.150 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {cmos_pclk}] -hold 0.110 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -setup 0.140 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -hold 0.100 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -setup 0.140 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -hold 0.100 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -setup 0.140 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -hold 0.100 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -setup 0.140 
set_clock_uncertainty -rise_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -hold 0.100 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[0]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {CLK}] -setup 0.140 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {CLK}] -hold 0.100 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {CLK}] -setup 0.140 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {CLK}] -hold 0.100 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {cmos_pclk}] -setup 0.150 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {cmos_pclk}] -hold 0.110 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {cmos_pclk}] -setup 0.150 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {cmos_pclk}] -hold 0.110 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -setup 0.140 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -hold 0.100 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -setup 0.140 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -hold 0.100 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -setup 0.140 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -hold 0.100 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -setup 0.140 
set_clock_uncertainty -fall_from [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -hold 0.100 
set_clock_uncertainty -rise_from [get_clocks {CLK}] -rise_to [get_clocks {CLK}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {CLK}] -fall_to [get_clocks {CLK}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {CLK}] -rise_to [get_clocks {CLK}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {CLK}] -fall_to [get_clocks {CLK}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -setup 0.100 
set_clock_uncertainty -rise_from [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -hold 0.070 
set_clock_uncertainty -rise_from [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -setup 0.100 
set_clock_uncertainty -rise_from [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -hold 0.070 
set_clock_uncertainty -fall_from [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -setup 0.100 
set_clock_uncertainty -fall_from [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -hold 0.070 
set_clock_uncertainty -fall_from [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -setup 0.100 
set_clock_uncertainty -fall_from [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -hold 0.070 
set_clock_uncertainty -rise_from [get_clocks {cmos_pclk}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -setup 0.110 
set_clock_uncertainty -rise_from [get_clocks {cmos_pclk}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -hold 0.150 
set_clock_uncertainty -rise_from [get_clocks {cmos_pclk}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -setup 0.110 
set_clock_uncertainty -rise_from [get_clocks {cmos_pclk}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -hold 0.150 
set_clock_uncertainty -rise_from [get_clocks {cmos_pclk}] -rise_to [get_clocks {cmos_pclk}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {cmos_pclk}] -fall_to [get_clocks {cmos_pclk}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {cmos_pclk}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -setup 0.110 
set_clock_uncertainty -fall_from [get_clocks {cmos_pclk}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -hold 0.150 
set_clock_uncertainty -fall_from [get_clocks {cmos_pclk}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -setup 0.110 
set_clock_uncertainty -fall_from [get_clocks {cmos_pclk}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -hold 0.150 
set_clock_uncertainty -fall_from [get_clocks {cmos_pclk}] -rise_to [get_clocks {cmos_pclk}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {cmos_pclk}] -fall_to [get_clocks {cmos_pclk}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -rise_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -setup 0.070 
set_clock_uncertainty -rise_from [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -rise_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -hold 0.100 
set_clock_uncertainty -rise_from [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -fall_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -setup 0.070 
set_clock_uncertainty -rise_from [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -fall_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -hold 0.100 
set_clock_uncertainty -rise_from [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -rise_to [get_clocks {cmos_pclk}]  0.030 
set_clock_uncertainty -rise_from [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -fall_to [get_clocks {cmos_pclk}]  0.030 
set_clock_uncertainty -rise_from [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -rise_to [get_clocks {camera_cfg:inst_camcfg|clock_20k}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -fall_to [get_clocks {camera_cfg:inst_camcfg|clock_20k}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -rise_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -setup 0.070 
set_clock_uncertainty -fall_from [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -rise_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -hold 0.100 
set_clock_uncertainty -fall_from [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -fall_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -setup 0.070 
set_clock_uncertainty -fall_from [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -fall_to [get_clocks {inst_100m|altpll_component|auto_generated|pll1|clk[2]}] -hold 0.100 
set_clock_uncertainty -fall_from [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -rise_to [get_clocks {cmos_pclk}]  0.030 
set_clock_uncertainty -fall_from [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -fall_to [get_clocks {cmos_pclk}]  0.030 
set_clock_uncertainty -fall_from [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -rise_to [get_clocks {camera_cfg:inst_camcfg|clock_20k}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {camera_cfg:inst_camcfg|clock_20k}] -fall_to [get_clocks {camera_cfg:inst_camcfg|clock_20k}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -setup 0.100 
set_clock_uncertainty -rise_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -hold 0.140 
set_clock_uncertainty -rise_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -setup 0.100 
set_clock_uncertainty -rise_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -hold 0.140 
set_clock_uncertainty -rise_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -rise_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -fall_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -rise_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -fall_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -setup 0.100 
set_clock_uncertainty -fall_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -hold 0.140 
set_clock_uncertainty -fall_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -setup 0.100 
set_clock_uncertainty -fall_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -hold 0.140 
set_clock_uncertainty -fall_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -rise_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -fall_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -rise_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}] -fall_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -setup 0.100 
set_clock_uncertainty -rise_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -hold 0.140 
set_clock_uncertainty -rise_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -setup 0.100 
set_clock_uncertainty -rise_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -hold 0.140 
set_clock_uncertainty -rise_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -rise_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -fall_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -rise_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -fall_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -setup 0.100 
set_clock_uncertainty -fall_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -rise_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -hold 0.140 
set_clock_uncertainty -fall_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -setup 0.100 
set_clock_uncertainty -fall_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -fall_to [get_clocks {inst_133m|altpll_component|auto_generated|pll1|clk[1]}] -hold 0.140 
set_clock_uncertainty -fall_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -rise_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -fall_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[1]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -rise_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}] -fall_to [get_clocks {sdram_top:inst_sdtop|sdram_ctrl:inst_sdctrl|init_st[0]}]  0.020 


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



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

