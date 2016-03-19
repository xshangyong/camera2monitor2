set_location_assignment PIN_R9 -to CLK
set_location_assignment PIN_M1 -to RSTn
set_location_assignment PIN_J1 -to led_o1
set_location_assignment PIN_J2 -to led_o2
set_location_assignment PIN_K1 -to led_o3
set_location_assignment PIN_K2 -to led_o4
set_location_assignment	PIN_L8	-to HSYNC_Sig
set_location_assignment	PIN_K6	-to VSYNC_Sig

set_location_assignment	PIN_L6	-to Red_Sig[0]
set_location_assignment	PIN_P3	-to Red_Sig[1]
set_location_assignment	PIN_N3	-to Red_Sig[2]
set_location_assignment	PIN_K5	-to Red_Sig[3]
set_location_assignment	PIN_L4	-to Red_Sig[4]
set_location_assignment	PIN_L1	-to Green_Sig[0]
set_location_assignment	PIN_L3	-to Green_Sig[1]
set_location_assignment	PIN_T3	-to Green_Sig[2]
set_location_assignment	PIN_R3	-to Green_Sig[3]
set_location_assignment	PIN_T2	-to Green_Sig[4]
set_location_assignment	PIN_R1	-to Green_Sig[5]
set_location_assignment	PIN_P2	-to Blue_Sig[0]
set_location_assignment	PIN_P1	-to Blue_Sig[1]
set_location_assignment	PIN_N2	-to Blue_Sig[2]
set_location_assignment	PIN_N1	-to Blue_Sig[3]
set_location_assignment	PIN_L2	-to Blue_Sig[4]



set_location_assignment	PIN_A10	-to sdram_data[0]
set_location_assignment	PIN_B10	-to sdram_data[1]
set_location_assignment	PIN_A11 -to sdram_data[2]
set_location_assignment	PIN_B11	-to sdram_data[3]
set_location_assignment	PIN_A12	-to sdram_data[4]
set_location_assignment	PIN_B12	-to sdram_data[5]
set_location_assignment	PIN_A13	-to sdram_data[6]
set_location_assignment	PIN_B13	-to sdram_data[7]
set_location_assignment	PIN_A2	-to sdram_data[8]
set_location_assignment	PIN_B1 	-to sdram_data[9]
set_location_assignment	PIN_C2	-to sdram_data[10]
set_location_assignment	PIN_D1	-to sdram_data[11]
set_location_assignment	PIN_F2	-to sdram_data[12]
set_location_assignment	PIN_F1	-to sdram_data[13]
set_location_assignment	PIN_G2	-to sdram_data[14]
set_location_assignment	PIN_G1	-to sdram_data[15]

set_location_assignment	PIN_F15	-to sdram_addr[0]
set_location_assignment	PIN_F16	-to sdram_addr[1]
set_location_assignment	PIN_G15	-to sdram_addr[2]
set_location_assignment	PIN_G16	-to sdram_addr[3]
set_location_assignment	PIN_C8	-to sdram_addr[4]
set_location_assignment	PIN_A7	-to sdram_addr[5]
set_location_assignment	PIN_B7	-to sdram_addr[6]
set_location_assignment	PIN_A6	-to sdram_addr[7]
set_location_assignment	PIN_B6	-to sdram_addr[8]
set_location_assignment	PIN_A5	-to sdram_addr[9]
set_location_assignment	PIN_D16	-to sdram_addr[10]
set_location_assignment	PIN_B5	-to sdram_addr[11]
set_location_assignment	PIN_A4	-to sdram_addr[12]

set_location_assignment	PIN_A3	-to sdram_clk
set_location_assignment	PIN_C16	-to sdram_ba[0]
set_location_assignment	PIN_D15	-to sdram_ba[1]
set_location_assignment	PIN_A15	-to sdram_ncas
set_location_assignment	PIN_B4	-to sdram_clke
set_location_assignment	PIN_B16	-to sdram_nras
set_location_assignment	PIN_B14	-to sdram_nwe
set_location_assignment	PIN_C15	-to sdram_ncs
set_location_assignment	PIN_B3	-to sdram_dqm[1]
set_location_assignment	PIN_A14	-to sdram_dqm[0]


set_location_assignment	PIN_N11	-to sclk 				
set_location_assignment	PIN_P11	-to sda						

#assigned by project
set_location_assignment	PIN_M7	-to cmos_vsyn		
set_location_assignment	PIN_N6	-to cmos_href		
set_location_assignment	PIN_M16	-to cmos_pclk  		
set_location_assignment	PIN_P9	-to cmos_xclk		
set_location_assignment	PIN_N9	-to cmos_data[0]
set_location_assignment	PIN_M9	-to cmos_data[1]
set_location_assignment	PIN_M10	-to cmos_data[2]
set_location_assignment	PIN_M8	-to cmos_data[3]
set_location_assignment	PIN_P8	-to cmos_data[4]
set_location_assignment	PIN_L7	-to cmos_data[5]
set_location_assignment	PIN_M6	-to cmos_data[6]
set_location_assignment	PIN_N8	-to cmos_data[7]


set_location_assignment PIN_N16	-to row_o[0];
set_location_assignment PIN_N15	-to row_o[1];
set_location_assignment PIN_L16	-to row_o[2];
set_location_assignment PIN_L14	-to row_o[3];
set_location_assignment PIN_K16	-to row_o[4];
set_location_assignment PIN_L15	-to row_o[5];
set_location_assignment PIN_J16 -to row_o[6];
set_location_assignment PIN_K15 -to row_o[7];

set_location_assignment PIN_P15	-to column_o[5];
set_location_assignment PIN_P16	-to column_o[4];
set_location_assignment PIN_K12	-to column_o[3];
set_location_assignment PIN_R16	-to column_o[2];
set_location_assignment PIN_M11	-to column_o[1];
set_location_assignment PIN_L13	-to column_o[0];


# assigned by datasheet
#set_location_assignment	PIN_M10	-to cmos_vsyn		
#set_location_assignment	PIN_M9	-to cmos_href		
#set_location_assignment	PIN_M16	-to cmos_pclk  		
#set_location_assignment	PIN_P9	-to cmos_xclk		
#set_location_assignment	PIN_M7	-to cmos_data[0]
#set_location_assignment	PIN_N6	-to cmos_data[1]
#set_location_assignment	PIN_N8	-to cmos_data[2]
#set_location_assignment	PIN_M6	-to cmos_data[3]
#set_location_assignment	PIN_L7	-to cmos_data[4]
#set_location_assignment	PIN_P8	-to cmos_data[5]
#set_location_assignment	PIN_N9	-to cmos_data[6]
#set_location_assignment	PIN_M8	-to cmos_data[7]



