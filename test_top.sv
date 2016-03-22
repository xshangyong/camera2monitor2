`timescale 1 ns / 1 ps
module test_top();



	parameter	ROW = 720;
	parameter	COL = 1024;
	reg 	CLK;
	reg		RSTn,ps2_clk_i,ps2_data_i;

	wire    led_o1     ;	
	wire    led_o2     ;
	wire    led_o3     ;
	wire    VSYNC_Sig  ;
	wire    HSYNC_Sig  ;
	wire[4:0]    Red_Sig    ;
	wire[5:0]     Green_Sig  ;
	wire[4:0]     Blue_Sig   ;
	wire[7:0]    row_o      ;
	wire[5:0]    column_o   ;
	wire[15:0]  sdram_data  ;
	wire[12:0]  sdram_addr  ;
	wire    	sdram_clk	;
	wire[1:0]   sdram_ba	;
	wire    	sdram_ncas  ;
	wire    	sdram_clke  ;
	wire    	sdram_nwe	;
	wire    	sdram_ncs	;
	wire[1:0]   sdram_dqm	;
	wire    	sdram_nras  ;
	
	wire		sda;
	wire		sclk;
	reg			cmos_vsyn;
	reg			cmos_href;
	reg			cmos_pclk;
	wire		cmos_xclk;
	reg[7:0]	cmos_data;
	
	reg[31:0] cnt = 0;
	reg[31:0] cnt_row = 0;
	reg[31:0] cnt_pix = 0;
	initial begin
		RSTn = 1;
		CLK = 0;
		cmos_pclk = 0;
		cmos_href = 0;
		cmos_vsyn = 0;
		cmos_data = 0;
	end
		
		
	always begin
		#10 CLK = ~CLK;
	end
	
	always begin
		#5.95 cmos_pclk = ~cmos_pclk;
	end
	
	always @(posedge cmos_pclk) begin
		if(cnt == 5596992) begin
			cnt <= cnt;
		end
		else begin
			cnt <= cnt + 1;
		end
		
		if( cnt >= 0 && cnt <= 2600) begin  // after  sdram initialized
			cmos_vsyn <= 1;
		end
		else begin
			cmos_vsyn <= 0;
		end
		
		if(cmos_vsyn == 0 && cnt_row < ROW) begin
			if(cnt_pix == 2148 ) begin
				cnt_row <= cnt_row + 1;
				cnt_pix <= 0;
				cmos_href <= 0;
			end
			else begin
				cnt_pix <= cnt_pix + 1;
				if(cnt_pix < 100) begin
					cmos_href <= 0;
				end
				else begin
					cmos_href <= 1;
					cmos_data <= cnt_pix[7:0];
				end
			end
			
		end
	end
	
	reg flag = 0;
	int file;
	reg[7:0]	data_d1 = 0;
	always @(posedge cmos_pclk) begin 
		if(cmos_vsyn == 0 &&cmos_href == 1) begin
			if(flag == 0) begin
				data_d1[7:0] <= cmos_data[7:0];
				flag <= 1;
			end
			else begin
				file = $fopen("./src.txt");
				fwrite(file,"%h %h\n",data_d1[7:0],cmos_data[7:0]);
				fclose(file);
			end
		end
	end
	
	
	vga_module dut
	(
		.CLK		(CLK		),
		.RSTn		(RSTn		),
		.led_o1     (led_o1   	),
		.led_o2     (led_o2   	),
		.VSYNC_Sig  (VSYNC_Sig	),
		.HSYNC_Sig  (HSYNC_Sig	),
		.Red_Sig    (Red_Sig  	),
		.Green_Sig  (Green_Sig	),
		.Blue_Sig   (Blue_Sig 	),
		.sdram_data	(sdram_data ),
		.sdram_addr	(sdram_addr	),
		.sdram_clk	(sdram_clk	),
		.sdram_ba	(sdram_ba	),
		.sdram_ncas	(sdram_ncas	),
		.sdram_clke	(sdram_clke	),
		.sdram_nwe	(sdram_nwe	),
		.sdram_ncs	(sdram_ncs	),
		.sdram_dqm	(sdram_dqm	),
		.sdram_nras (sdram_nras	),
		.sda		(sda		),
		.sclk		(sclk		),
		.cmos_vsyn	(cmos_vsyn	),
		.cmos_href	(cmos_href	),
		.led_o3     (led_o3   	),
		.cmos_pclk	(cmos_pclk	),
		.cmos_xclk	(cmos_xclk	),
		.cmos_data	(cmos_data	)
	);
	
	sdram inst_sdram
	(
		.Dq		(sdram_data), 
		.Addr	(sdram_addr), 
		.Ba		(sdram_ba), 
		.Clk	(sdram_clk), 
		.Cke	(sdram_clke), 
		.Cs_n	(sdram_ncs), 
		.Ras_n	(sdram_nras), 
		.Cas_n	(sdram_ncas), 
		.We_n	(sdram_nwe), 
		.Dqm	(1'b0)	
	);

endmodule