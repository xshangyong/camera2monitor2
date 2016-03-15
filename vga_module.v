module vga_module
(
	CLK, 
	RSTn,
	VSYNC_Sig, 
	HSYNC_Sig,
	Red_Sig, 
	Green_Sig, 
	Blue_Sig,

	led_o1,
	led_o2,
	led_o3,
	led_o4,
	sdram_data,
	sdram_addr,
	sdram_clk,
	sdram_ba,
	sdram_ncas,
	sdram_clke,
	sdram_nwe,
	sdram_ncs,
	sdram_dqm,
	sdram_nras,
	
	sda,
	sclk,
	
	cmos_vsyn,
	cmos_href,
	cmos_pclk,
	cmos_xclk,
	cmos_data	
);

	input 	CLK;
	input 	RSTn;		// low valid

	// led
	output 	led_o1;
	output 	led_o2;
	output 	led_o3;
	output 	led_o4;
	// vga
	output reg 	VSYNC_Sig;
	output reg 	HSYNC_Sig;
	output[4:0]	Red_Sig;
	output[5:0]	Green_Sig;
	output[4:0]	Blue_Sig;

	// sdram
	inout[15:0] 	sdram_data;
	output[12:0]	sdram_addr;
	output	 		sdram_clk;
	output[1:0]		sdram_ba;
	output	 		sdram_ncas;
	output	 		sdram_clke;
	output	 		sdram_nwe;
	output	 		sdram_ncs;
	output[1:0]		sdram_dqm;
	output			sdram_nras;

	// i2c camera config
	output 	sclk;
	inout 	sda;
	// cmos camera	
	input		cmos_vsyn;
    input   	cmos_href;
    input   	cmos_pclk;
    output   	cmos_xclk;
    input[7:0]  cmos_data;

 	
	/*************************************/
	
	wire 			VSYNC_Sig_d1;
	wire 			HSYNC_Sig_d1;
	wire 			clk_100M;
	wire [10:0]		Column_Addr_Sig;
	wire [10:0]		Row_Addr_Sig;
	wire 			Ready_Sig;
	wire [15:0]		rom_addr;
	wire [2:0]		rom_dat;
	wire  [2:0]     rom_dat_use;
	wire[15:0]		rd_rom_add;
	wire [2:0]		fifo_dat;
	wire			is_pic;
	wire[10:0]		fifo_used;
	wire[10:0]		rd_fifo_used;
	wire[4:0]		work_st;
	reg				wr_sdram_req=0;
	wire			wr_sdram_ack;
	reg[23:0]		wr_sdram_add=0;
	wire[15:0]		wr_sdram_data;
	
	wire			rst_100o;
	wire			rst_133o;
	
	wire			rst_100;
	wire			rst_133;
	
	reg				rd_sdram_req=0;
	wire			rd_sdram_ack;
	reg[23:0]		rd_sdram_add=0;
	wire[15:0]		rd_sdram_data;
	reg				wr_sdram_finish;
	reg				wr_sdram_finisha;
	reg				wr_sdram_finishb;

	reg[2:0]		st_wrsdram = 0;
	reg[2:0]		st_rdsdram = 0;
	reg[8:0]		wr_sdram_times = 0;
	wire			fifo_clear;
	wire[15:0]		data_vga;
	wire[15:0]		cnt_work;
	wire			vga_rdfifo;
	parameter 		Clear 	= 2'b00;
	parameter 		Idle 	= 2'b01;
	parameter 		Wr_fifo 	= 2'b10; 
	parameter 		None2 	= 2'b11;

	parameter	W_IDLE		= 4'd0;		//idle
	parameter	W_ACTIVE	= 4'd1;		//row active 
	parameter	W_TRCD		= 4'd2;		//row active wait time  min=20ns
	parameter	W_REF		= 4'd3;		//auto refresh
	parameter	W_RC		= 4'd4;		//auto refresh wait time min=63ns
	parameter	W_READ		= 4'd5;		//read cmd
	parameter	W_RDDAT		= 4'd6;		//read data
	parameter	W_CL		= 4'd7;		//cas latency
	parameter	W_WRITE		= 4'd8;		//auto write
	parameter	W_PRECH		= 4'd9;		//precharge
	parameter	W_TRP		= 4'd10;	//precharge wait time  min=20ns
	parameter	W_BSTOP		= 4'd11;	//precharge wait time  min=20ns
	parameter	W_CHGACT	= 4'd12;	//precharge before act
	parameter	W_TRPACT	= 4'd13;	//precharge before act
	// 14 13 12 11 0010
	// 10 9  8  7  1000
	// 9 8 7 6		
//	assign led_o1 = cnt_pclk[14];
//	assign led_o2 = cnt_pclk[13];
//	assign led_o3 = cnt_pclk[12];
//	assign led_o4 = cnt_pclk[11];




	reg[19:0]	test_rdsdram = 0;
	reg[31:0]	cnt_vsyn_neg = 0;
	wire			clk_tmp80M;
	wire			clk_24M;
	wire			clk_cfg;
	assign Red_Sig[4:1] = {Red_Sig[0],Red_Sig[0],Red_Sig[0],Red_Sig[0]};
	assign Green_Sig[5:1] = {Green_Sig[0],Green_Sig[0],Green_Sig[0],Green_Sig[0],Green_Sig[0]};
	assign Blue_Sig[4:1] = {Blue_Sig[0],Blue_Sig[0],Blue_Sig[0],Blue_Sig[0]};
	assign cmos_xclk = clk_24M;	
//	assign Red_Sig[4:0] = 5'b11111;
//	assign Green_Sig[4:0] = 5'b11111;
//	assign Blue_Sig[5:0] = 6'b11111;
	reg[31:0]	cnt_100 = 0;
	reg[31:0]	cnt_pclk = 0;
	reg[31:0]	cnt_pclk_r = 0;
	reg[31:0]	cnt_ref = 0;
	reg[31:0]	cnt_pix = 0;
	reg[31:0]	cnt_vsyn = 0;
	reg			pclk_valid = 0;
	wire		test_sda;
	wire		test_sclk;
	wire		cfg_done;
	reg			cmos_href_d1,cmos_href_d2;
	reg			cmos_vsyn_d1,cmos_vsyn_d2;
	wire		href_neg,href_pos;
	wire[15:0]	data_16b;
	wire		data_16b_en;
	/*	//..//..//..//..//   test code  begin
	assign led_o1 =  cnt_pix >  2048 ? 1 : 0;
	assign led_o2 =  cnt_pix ==  2048 ? 1 : 0;
	assign led_o3 =  cnt_pix ==  2047 ? 1 : 0;
	assign led_o4 =  cnt_pix ==  2046 ? 1 : 0;
	
	always@(posedge cmos_pclk)begin
		cmos_href_d1 <= cmos_href;
		cmos_href_d2 <= cmos_href_d1;
		cmos_vsyn_d1 <= cmos_vsyn;
		cmos_vsyn_d2 <= cmos_vsyn_d1;	
	end
	assign href_pos = ~cmos_href_d2 & cmos_href_d1;
	assign href_neg = cmos_href_d2 & ~cmos_href_d1;	
	assign vsyn_pos = ~cmos_vsyn_d2 & cmos_vsyn_d1;
	
	
	always@(posedge cmos_pclk)begin
		if(href_neg) begin
			cnt_pix <= 0;
		end
		else if(cmos_href) begin
			cnt_pix <= cnt_pix + 1;
		end
		
		
		if(vsyn_pos) begin
			cnt_ref <= 0;
		end
		else if(href_neg) begin
			cnt_ref <= cnt_ref + 1;
		end
		
		
	end
	
	always@(posedge clk_100M) begin
		if(!cfg_done) begin
			cnt_100 <= 0;
			pclk_valid <= 0;
		end
		else begin
			if(cnt_100 < 10000) begin
				cnt_100 <= cnt_100 + 1;	
				pclk_valid <= 1;
			end			
			else begin
				cnt_100 <= cnt_100;
				pclk_valid <= 0;
			end
		end
	end
	
//..//..//..//..//   test code end
*/
 	recv_cam inst_recv(
		.cmos_data	(cmos_data),
		.cmos_pclk	(cmos_pclk),
		.cmos_href	(cmos_href),
		.cfg_done	(cfg_done),
		.data_16b	(data_16b),
		.data_16b_en(data_16b_en)
	);
	
	cam2fifo inst_cam2fifo(
		.cmos_pclk		(cmos_pclk),
		.clk_133M_i		(clk_133M),
		.rst_100i		(rst_100),
		.rst_133i		(rst_133),
		.data_16b		(data_16b),
		.data_16b_en	(data_16b_en),
		.fifo_used_o	(fifo_used),
		.wr_sdram_data	(wr_sdram_data),
		.work_st		(work_st)
	);

	
	
	camera_cfg inst_camcfg(
		.clk_25M	(clk_cfg),
		.rst_100    (rst_100),
		.sclk		(sclk),
		.sda		(sda),
		.cfg_done	(cfg_done)
	); 
	
	reg_config	reg_config_inst(
		.clk_25M                 (clk_cfg),
		.camera_rstn             (rst_100),
		.initial_en              (),		
		.i2c_sclk                (),
		.i2c_sdat                (),
		.reg_conf_done           (),
		.strobe_flash            (),
		.reg_index               (),
		.clock_20k               (),
		.key1                    (1'b1)
	);
	
	
	clk_100m inst_100m(
	    .inclk0( CLK ),    // input - from top
		.c0( clk_tmp80M ),  //  100MHz
		.c1(clk_24M),		// 24M to cmos_camera
		.c2(clk_cfg)		// 25M to cfg camera
	);

	pll_133 inst_133m(
	    .inclk0( clk_tmp80M ),
		.c0( clk_100M ),   	// 100MHz
		.c1( clk_133M  )    // 125MHz
	);	 	
	 /**************************************/
	reset_gen inst_rst(
		.clk_100	(clk_100M),
		.clk_133    (clk_133M),
		.rst_n      (RSTn),
		.rst_100    (rst_100),
		.rst_133	(rst_133)
	);

	
	sdram_top inst_sdtop
	(
		.clk			(clk_133M	),  // use 133MHz clk
		.rst_n			(rst_133	),
		.sdram_data		(sdram_data	),
		.sdram_addr		(sdram_addr	),
		.sdram_clk		(sdram_clk	),
		.sdram_ba		(sdram_ba	),
		.sdram_ncas		(sdram_ncas	),
		.sdram_clke		(sdram_clke	),
		.sdram_nwe		(sdram_nwe	),
		.sdram_ncs		(sdram_ncs	),
		.sdram_dqm		(sdram_dqm	),
		.sdram_nras 	(sdram_nras ),
		.wr_sdram_req	(wr_sdram_req),
		.wr_sdram_ack	(wr_sdram_ack),
		.wr_sdram_add	(wr_sdram_add),
		.wr_sdram_data  (wr_sdram_data),
		.rd_sdram_req	(rd_sdram_req),
		.rd_sdram_ack	(rd_sdram_ack),
		.rd_sdram_add	(rd_sdram_add),
		.rd_sdram_data  (rd_sdram_data),
		.work_st		(work_st),
		.cnt_work		(cnt_work)
	);

	// read sdram, rd_sdram_req high means read begins,ack high means read finished 
	// start when wr_sdram_finish == 1 && vsync negadge
	reg		wr_en;
//	wire 	rd_en;
	/*
	always@(posedge clk_133M or negedge rst_133)begin
		if(!rst_133) begin
			rd_en <= 0;
		end
		else if(work_st == W_RDDAT && rd_sdram_add[21:9]==0)begin
			rd_en <= 1;
		end
		else if(work_st == W_RDDAT && rd_sdram_add[21:9]<=200)begin
			rd_en <= 0;
		end
		else begin
			rd_en <= rd_en;
		end
	end
	*/
	//  && (rd_sdram_add[21:9]<=400)
//	assign rd_en = ((work_st == W_RDDAT) && (rd_sdram_add[21:9]==0) ) ? 1 : 0;
	always@(posedge clk_133M or negedge rst_133)begin
		if(!rst_133) begin
			wr_en <= 0;
		end
		else if(work_st == W_WRITE && wr_sdram_add[21:9]==0)begin
			wr_en <= 1;
		end
		else if(work_st == W_WRITE && wr_sdram_add[21:9]<=200)begin
			wr_en <= 0;
		end
		else begin
			wr_en <= wr_en;
		end
	end
	
	always@(posedge clk_133M or negedge rst_133)begin
		if(!rst_133) begin
			test_rdsdram <= 0;
		end
		else if(work_st == W_RDDAT && cnt_work == 0 && rd_sdram_add[21:9]==0) begin
			test_rdsdram[8:6] <= sdram_data[2:0];	
		end
		else if(work_st == W_RDDAT && cnt_work == 1 && rd_sdram_add[21:9]==0) begin
			test_rdsdram[5:3] <= sdram_data[2:0];	
		end
		else if(work_st == W_RDDAT && cnt_work == 2 && rd_sdram_add[21:9]==0) begin
			test_rdsdram[2:0] <= sdram_data[2:0];	
		end
		else if(work_st == W_WRITE && wr_en==1)begin
			case(cnt_work)
				3 : test_rdsdram[11:9] <= sdram_data[2:0];
				2 :	test_rdsdram[14:12] <= sdram_data[2:0];
				1 :	test_rdsdram[17:15] <= sdram_data[2:0];	
			endcase
		end
	end

	always@(posedge clk_133M or negedge rst_133)begin
		if(!rst_133) begin
			rd_sdram_req <= 0;
			rd_sdram_add <= 0;
			st_rdsdram   <= 0;
		end
		else begin
			if(VSYNC_Sig_d1 == 0) begin
				st_rdsdram <= 0;
				rd_sdram_add <= 0;
				rd_sdram_req <= 0;
			end
			else begin
				case(st_rdsdram)
					0 : begin
						if( wr_sdram_finishb == 1 &&
							rd_fifo_used <= 512 &&
							rd_sdram_add[21:9] < 128) begin
							st_rdsdram <= 1;
							rd_sdram_req <= 1;
						end
					end	
					1 : begin
						if(rd_sdram_ack == 1) begin
							rd_sdram_add[21:9] <= rd_sdram_add[21:9] + 1'b1;
							rd_sdram_req <= 0;
							st_rdsdram <= 0;
						end
					end
				endcase
			end
		end
	   end
	
	
	always@(posedge clk_133M or negedge rst_133)begin
		if(!rst_133) begin
			wr_sdram_finishb <= 0;
		end
		else if (wr_sdram_add[21:9] >= 127)begin //(wr_sdram_add[21:9] == 127  && VSYNC_Sig == 0 )begin
			wr_sdram_finishb <= 1;
		end
	end
	
	always@(posedge clk_100M or negedge rst_100)begin
		if(!rst_100) begin
			wr_sdram_finisha <= 0;
			wr_sdram_finish <= 0;
		end
		else begin
			wr_sdram_finisha <= wr_sdram_finishb;
			wr_sdram_finish  <= wr_sdram_finisha;
		end
	end

	// write sdram, wr_sdram_req high means write begins,ack high means write finished 
	// start when fifo_used >= 512
	always@(posedge clk_133M or negedge rst_133)begin
		if(!rst_133) begin
			wr_sdram_req   <= 0;
			wr_sdram_add   <= 0;
			wr_sdram_times <= 0;
			st_wrsdram     <= 0;
		end
		else begin
			case(st_wrsdram)
				0 : begin
					if(wr_sdram_times < 128 &&
						fifo_used >= 512) begin
						st_wrsdram <= 1;
						wr_sdram_req <= 1;
					end
				end	
				1 : begin
					if(wr_sdram_ack == 1) begin
						// row addr:wr_sdram_add[21:9], column addr:wr_sdram_add[8:0]
						wr_sdram_add[21:9] <= wr_sdram_add[21:9] + 1'b1;
						wr_sdram_req <= 0;
						st_wrsdram <= 0;
						wr_sdram_times <= wr_sdram_times + 8'b1;
					end
				end
			endcase
		end
   end

	fifo2vga	inst_fifo2vga
	(
		.clk_133M_i		(clk_133M),
		.clk_100M		(clk_100M),
		.rst_100i		(rst_100),
		.rst_133i		(rst_133),
		.fifo_used_o	(rd_fifo_used),
		.sdram_data		(sdram_data),
		.work_st		(work_st),
		.cnt_work		(cnt_work),
		.fifo_clear		(fifo_clear),
		.data_vga		(data_vga),
		.vga_rdfifo		(vga_rdfifo)
	);
	
	
//	assign to_dig[19:0] = test_rdsdram[2:0]+test_rdsdram[5:3]*10+test_rdsdram[8:6]*100+test_rdsdram[11:9]*1000+test_rdsdram[14:12]*10000+test_rdsdram[17:15]*100000;
	   
	   
	   

	 

	

	 
	/*
	 always@(posedge CLK)begin
		if(ps2_done_r == 1) begin
			if(ps2_break_r == 2'b01) begin
				 led_r1 <= 1;
				 led_r2 <= 0;
				 led_r3 <= 0;
			end
			else if(ps2_break_r == 2'b10) begin
				 led_r1 <= 0;
				 led_r2 <= 1;
				 led_r3 <= 0;
		   end
		end
	 end
	*/
	 always@(posedge clk_100M)begin
		  VSYNC_Sig<= VSYNC_Sig_d1;
		  HSYNC_Sig<= HSYNC_Sig_d1;
	 end
assign  fifo_clear  = VSYNC_Sig_d1 & ~VSYNC_Sig;  //negadge
assign  vsyn_neg    = VSYNC_Sig_d1 & ~VSYNC_Sig;  //negadge
assign  vga_rdfifo 	= is_pic & Ready_Sig & wr_sdram_finish;
	 
	 
	 
	reg rst_vgasyn,rst_vgasyn1,rst_vgasyn2;
	
	always @(*) begin
		if(!rst_133) begin
			rst_vgasyn = 0;
		end
		else begin
			if(wr_sdram_add[21:9] >= 127) begin
				rst_vgasyn = 1;
			end
		end
	end

	always @ ( posedge clk_100M) begin
		rst_vgasyn1 <= rst_vgasyn;
		rst_vgasyn2 <= rst_vgasyn1;
	end
	
	sync_module inst_sync
	(
		.CLK( clk_100M ),
		.RSTn( rst_vgasyn2  ), //rst_100
		.VSYNC_Sig( VSYNC_Sig_d1 ),   // output - to top
		.HSYNC_Sig( HSYNC_Sig_d1 ),   // output - to top
		.Column_Addr_Sig( Column_Addr_Sig ), // output - to inst_vga_control
		.Row_Addr_Sig( Row_Addr_Sig ),       // output - to inst_vga_control
		.Ready_Sig( Ready_Sig )              // output - to inst_vga_control
	);
	 
	 /******************************************/
	 
	 vga_control_module inst_vga_control
	 (
	      .CLK( clk_100M ),
		  .RSTn( rst_vgasyn2 ), //rst_100
		  .Ready_Sig( Ready_Sig ),             // input - from inst_sync
		  .Column_Addr_Sig( Column_Addr_Sig ), // input - from inst_sync
		  .Row_Addr_Sig( Row_Addr_Sig ),       // input - from inst_sync
		  .Red_Sig( Red_Sig[0] ),      // output - to top
		  .Green_Sig( Green_Sig[0] ),  // output - to top
		  .Blue_Sig( Blue_Sig[0] ),    // output - to top
		  .ps2_data_i( ),
		  .rom_addr_o(rom_addr),
		  .display_data(data_vga[2:0]),
		  .is_pic(is_pic)
	 );


endmodule
