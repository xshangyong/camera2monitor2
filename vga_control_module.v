

module vga_control_module
(
    CLK, RSTn,
	 Ready_Sig, Column_Addr_Sig, Row_Addr_Sig,
	 Red_Sig, Green_Sig, Blue_Sig,
	 ps2_data_i,
	 display_data,
	 is_pic
);


	 input CLK;
	 input RSTn;
	 input Ready_Sig;
	 input [10:0]	Column_Addr_Sig;
	 input [10:0]	Row_Addr_Sig;
	 input [7:0] 	ps2_data_i;
	 input [15:0]	display_data;
	 output[4:0] Red_Sig;
	 output[5:0] Green_Sig;
	 output[4:0] Blue_Sig;
	 output is_pic;
	
	assign is_pic = Ready_Sig ;//(Row_Addr_Sig <= 720 && Column_Addr_Sig <= 1024) ? 1 : 0;
					

	
	assign Red_Sig[4:0]   = Ready_Sig && is_pic ? display_data[15:11] : 0;
	assign Green_Sig[5:0] = Ready_Sig && is_pic ? display_data[10:5]  : 0;
	assign Blue_Sig[4:0]  = Ready_Sig && is_pic ? display_data[4:0]   : 0;
	 
	 

endmodule
