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
	cmos_data,
	
	row_o,
	column_o,
	
	clk_100M
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

	// digitron
	output[7:0]		row_o;
	output[5:0]		column_o;
 	
	/*************************************/
	output 			clk_100M;
	
	wire 			VSYNC_Sig_d1;
	wire 			HSYNC_Sig_d1;
	wire [10:0]		Column_Addr_Sig;
	wire [10:0]		Row_Addr_Sig;
	wire 			Ready_Sig;
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

	reg[2:0]		st_wrsdram = 0;
	reg[2:0]		st_rdsdram = 0;
	reg[8:0]		wr_sdram_times = 0;
	wire				clk_133M;
	wire				clk_45M;
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
	assign cmos_xclk = clk_24M;	
//	assign Red_Sig[4:0] = 5'b11111;
//	assign Green_Sig[4:0] = 5'b11111;
//	assign Blue_Sig[5:0] = 6'b11111;
	reg[31:0]	cnt_100 = 0;
	reg[31:0]	cnt_pclk = 0;
	reg[31:0]	cnt_ref_r = 0;
	reg[31:0]	cnt_ref = 0;
	reg[31:0]	cnt_pix = 0;
	reg[31:0]	cnt_pix2 = 0;
	reg[31:0]	cnt_pix_r = 0;
	reg[31:0]	cnt_vsyn = 0;
	reg			pclk_valid = 0;
	wire		test_sda;
	wire		test_sclk;
	wire		cfg_done;
	reg			cmos_href_d1,cmos_href_d2;
	reg			cmos_vsyn_d1,cmos_vsyn_d2;
	wire		href_neg,href_pos,vsyn_pos,vsyn_neg2;
	wire[15:0]	data_16b;
	wire		data_16b_en;
	reg			bank_switch = 0;
	wire		vga_vsyn_pos,vga_vsyn_neg;
	wire[1:0]	vga_bank,cam_bank;
	wire[1:0]	bk3_state;
	reg			clear_rdsdram_fifo;
	reg			clear_wrsdram_fifo;
	wire[7:0]	virt_data;
	wire		virt_href;
	wire		virt_vsyn;
	
	
	assign led_o1 =  st_wrsdram; 
	assign led_o2 =  st_rdsdram; 
	assign led_o3 =  wr_sdram_req; 
	assign led_o4 =  wr_sdram_ack; 
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
	
*/	
	

	always@(posedge cmos_pclk)begin
		if(pclk_valid) begin
			cnt_pix2 <= cnt_pix2 + 1;
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

	assign href_pos = ~cmos_href_d2 & cmos_href_d1;
	assign href_neg = cmos_href_d2 & ~cmos_href_d1;	
	assign vsyn_pos = ~cmos_vsyn_d2 & cmos_vsyn_d1;
	assign vsyn_neg2 = cmos_vsyn_d2 & ~cmos_vsyn_d1;
	
	wire cam_en;
	assign cam_en = (cnt_vsyn >= 20) ? 1 : 0;



	always@(posedge cmos_pclk)begin
//		if(!RSTn) begin
//			cnt_vsyn  <= 0;
//			cnt_ref   <= 0;
//			cnt_pix   <= 0;
//			cnt_pix_r <= 0;
//		end
		cmos_vsyn_d1 <= cmos_vsyn;
		cmos_vsyn_d2 <= cmos_vsyn_d1;
		cmos_href_d1 <= cmos_href;
		cmos_href_d2 <= cmos_href_d1;
		
		if(vsyn_pos == 1) begin
			if(cnt_vsyn == 30) begin
				cnt_vsyn <= cnt_vsyn;
			end
			else begin
				cnt_vsyn <= cnt_vsyn + 1;
			end
		end
	
		if(vsyn_pos == 1) begin
			cnt_ref <= 0;
			cnt_ref_r <= cnt_ref;
		end
		else begin
			if(href_pos == 1) begin
				cnt_ref <= cnt_ref + 1;
			end
		end
		
		if(vsyn_pos == 1) begin
			cnt_pix <= 0;
			cnt_pix_r <= cnt_pix;
		end
		else if(cmos_href == 1) begin
			cnt_pix <= cnt_pix + 1;
		end

	end

	
	generate_cam inst_cam(
		.cmos_pclk	(clk_45M),
		.cmos_data	(virt_data),
		.cmos_href	(virt_href),
		.cmos_vsyn	(virt_vsyn)
	);

	
 	recv_cam inst_recv(
		.cmos_data	(cmos_data),
		.cmos_pclk	(cmos_pclk),
		.cmos_href	(cmos_href),
		.cmos_vsyn	(cmos_vsyn),
		.cfg_done	(cfg_done),
		.data_16b	(data_16b),
		.data_16b_en(data_16b_en),
		.cnt_ref	(cnt_ref)
	);
	
	cam2fifo inst_cam2fifo(
		.cmos_pclk			(cmos_pclk),
		.clk_133M_i			(clk_133M),
		.rst_133i			(rst_133),
		.clear_wrsdram_fifo	(clear_wrsdram_fifo),
		.data_16b			(data_16b),
		.data_16b_en		(data_16b_en),
		.fifo_used_o		(fifo_used),
		.wr_sdram_data		(wr_sdram_data),
		.work_st			(work_st)
	);

	
	
	camera_cfg inst_camcfg(
		.clk_25M	(clk_cfg),
		.rst_100    (rst_100),
		.sclk		(sclk),
		.sda		(sda),
		.cfg_done	(cfg_done)
	); 
	
//	reg_config	reg_config_inst(
//		.clk_25M                 (clk_cfg),
//		.camera_rstn             (rst_100),
//		.initial_en              (),		
//		.i2c_sclk                (),
//		.i2c_sdat                (),
//		.reg_conf_done           (),
//		.strobe_flash            (),
//		.reg_index               (),
//		.clock_20k               (),
//		.key1                    (1'b1)
//	);
	
	
	clk_100m inst_100m(
	    .inclk0( CLK ),    // input - from top
		.c0( clk_tmp80M ),  //  100MHz
		.c1(clk_24M),		// 24M to cmos_camera
		.c2(clk_cfg)		// 25M to cfg camera
	);

	pll_133 inst_133m(
	    .inclk0( clk_tmp80M ),
		.c0( clk_100M ),   	// 40
		.c1( clk_133M  ),    // 80MHz
		.c2( clk_45M   )
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
	
	bank_switch		inst_bkswitch
	(
		.clk			(clk_133M		),  // use 133MHz clk
		.rst_133		(rst_133		),
		.button			(RSTn			),
		.vga_rise		(VSYNC_Sig_d1	),	
		.cam_rise		(cmos_vsyn		),
		.vga_bank		(vga_bank		),
		.cam_bank		(cam_bank		),
		.bk3_state		(bk3_state		)
	);
	
	
	wire  rd_fifo_valid,vga_vsyn_pos133;
	reg	rdfifo_valid_d1, rdfifo_valid_d2;
	reg	vga_vsyn_d1, vga_vsyn_d2;
	assign rd_fifo_valid = rd_fifo_used <= 512 ? 1 : 0;
	assign vga_vsyn_pos133 = vga_vsyn_d1 & ~vga_vsyn_d2;
	always@(posedge clk_133M or negedge rst_133)begin
		if(!rst_133) begin
			rdfifo_valid_d1 <= 0;
			rdfifo_valid_d2 <= 0;
			vga_vsyn_d1   	<= 0;
			vga_vsyn_d2  	<= 0;
		end
		else begin
			rdfifo_valid_d1 <= rd_fifo_valid;
			rdfifo_valid_d2 <= rdfifo_valid_d1;
			vga_vsyn_d1 <= VSYNC_Sig_d1;
			vga_vsyn_d2 <= vga_vsyn_d1;
		end	
	end
	
	reg[21:9]	test_rdsdram_addr;

	//	read SDRAM
	always@(posedge clk_133M or negedge rst_133)begin
		if(!rst_133) begin
			rd_sdram_req 		<= 0;
			rd_sdram_add 		<= 0;
			st_rdsdram   		<= 0;
			clear_rdsdram_fifo 	<= 0;
		end
		else begin
			if(vga_vsyn_pos133 == 1) begin		// vga vsyn rise edge  clear fifo ,switch bank, initial addr
				st_rdsdram 			<= 0;
				rd_sdram_add[21:9] 	<= 0;
				rd_sdram_req 		<= 0;
				clear_rdsdram_fifo 	<= 1;
				rd_sdram_add[23:22] <= vga_bank;
				test_rdsdram_addr[21:9]	<= rd_sdram_add[21:9];
			end
			else begin
				clear_rdsdram_fifo <= 0;
				case(rd_sdram_req)
					0 : begin
						if(rdfifo_valid_d2 == 1 && rd_sdram_add[21:9] < 750) begin// 
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
	


	

	// sync cnt_vsyn and fifo_used
	// fifo_used >= 512 && cnt_vsyn == 20
	wire  fifo_used_valid, cnt_vsyn_valid,cnt_vsyn_min;
	assign fifo_used_valid = fifo_used >= 512 ? 1 : 0;
	assign cnt_vsyn_valid = cnt_vsyn == 20 ? 1 : 0;
	assign cnt_vsyn_min = cnt_vsyn < 20 ? 1 : 0;
	
	reg	fifo_valid_d1, fifo_valid_d2;
	reg	vsyn_valid_d1, vsyn_valid_d2;
	reg	cnt_vsyn_min_d1, cnt_vsyn_min_d2;
	
	always@(posedge clk_133M or negedge rst_133)begin
		if(!rst_133) begin
			fifo_valid_d1   <= 0;
			fifo_valid_d2   <= 0;
			vsyn_valid_d1   <= 0;
			vsyn_valid_d2   <= 0;
			cnt_vsyn_min_d1 <= 0;
			cnt_vsyn_min_d2 <= 0;
		end
		else begin
			fifo_valid_d1 <= fifo_used_valid;
			fifo_valid_d2 <= fifo_valid_d1;
			vsyn_valid_d1 <= cnt_vsyn_valid;
			vsyn_valid_d2 <= vsyn_valid_d1;
			cnt_vsyn_min_d1 <= cnt_vsyn_min;
			cnt_vsyn_min_d2 <= cnt_vsyn_min_d1;
		end
	end
	//	write SDRAM
	reg	cmos_v133_d1,cmos_v133_d2;
	reg[21:9]	test_wrsdram_addr;
	wire	cmos_v133_neg;
	assign	cmos_v133_neg =  ~cmos_v133_d1 & cmos_v133_d2;
	always@(posedge clk_133M or negedge rst_133)begin
		if(!rst_133) begin
			cmos_v133_d1 <= 0;
			cmos_v133_d2 <= 0;
		end
		else begin
			cmos_v133_d1 <= cmos_vsyn;
			cmos_v133_d2 <= cmos_v133_d1;		
		end
	end
	always@(posedge clk_133M or negedge rst_133)begin
		if(!rst_133) begin
			wr_sdram_req   <= 0;
			wr_sdram_add   <= 0;
			st_wrsdram     <= 0;
			clear_wrsdram_fifo <= 0;
		end
		else begin
			if(cmos_v133_neg) begin
				st_wrsdram 			<= 0;
				wr_sdram_add[21:9] 	<= 0;
				wr_sdram_add[23:22]	<= cam_bank;
				wr_sdram_req 		<= 0;
				clear_wrsdram_fifo	<= 1;
				test_wrsdram_addr[21:9]	<= wr_sdram_add[21:9];
				cnt_wrreq_r <= cnt_wrreq;
				cnt_wrreq   <= 0;
			end
			else begin
				clear_wrsdram_fifo <= 0;
				if(pos_wrreq) begin
					cnt_wrreq <= cnt_wrreq + 1;
				end
				case(wr_sdram_req)
					0 : begin
						if(fifo_valid_d2) begin
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
						end
					end
				endcase
			end
		end
   end
   //sdram write reg count
   reg[31:0]	cnt_wrreq,cnt_wrreq_r;
   reg		wrreq_d1,wrreq_d2;
   wire  	pos_wrreq;
   assign   pos_wrreq = wrreq_d1 & ~wrreq_d2;
	always@(posedge clk_133M or negedge rst_133)begin
		wrreq_d1 <= wr_sdram_req;
		wrreq_d2 <= wrreq_d1;
	end

   	reg	wr_req_d1;
	reg[31:0] cnt_req = 0;
	always@(posedge clk_133M)begin
		wr_req_d1 <=  wr_sdram_req;
		if(wr_sdram_req == 1 && wr_req_d1 == 0) begin
			cnt_req <= cnt_req + 1;
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
		.fifo_clear		(clear_rdsdram_fifo),
		.data_vga		(data_vga),
		.vga_rdfifo		(vga_rdfifo)
	);	
	
	wire[19:0] digi;
	reg[19:0]	cnt_vga_vsyn_r=0;
//	assign digi =  cnt_ref_r[9:0]*1000 + cnt_pix_r[11:2] ;
	assign digi =  cnt_wrreq_r[9:0]*1000 + test_wrsdram_addr[18:9] ;
	
	digitron inst_digi
	(
		.clk_i(CLK),
		.rst_i(rst_100),
		.num_i(cnt_wrreq_r[19:0]),	//{7'h0,wr_sdram_add[21:9]}
		.row_o(row_o),
		.column_o(column_o)
	);

	
	 always@(posedge clk_100M)begin
		  VSYNC_Sig<= VSYNC_Sig_d1;
		  HSYNC_Sig<= HSYNC_Sig_d1;
	 end
	assign  fifo_clear  = VSYNC_Sig_d1 & ~VSYNC_Sig;   
	assign  vga_vsyn_pos    = VSYNC_Sig_d1 & ~VSYNC_Sig;  //posadge
	assign  vga_vsyn_neg    = ~VSYNC_Sig_d1 & VSYNC_Sig;  //negadge
	assign  vga_rdfifo 	= is_pic & Ready_Sig;
		
/* 	reg	cmos_vsyn_100d1,cmos_vsyn_100d2;		
	reg	cnt_vsyn_100valid_100d1,cnt_vsyn_100valid_100d2;
	wire cmos_vsyn_100pos, cnt_vsyn_100valid,coms_vsyn_100pos;
	always@(posedge clk_100M)begin
		cmos_vsyn_100d1 <= cmos_vsyn;
		cmos_vsyn_100d2 <= cmos_vsyn_100d1;
		
		cnt_vsyn_100valid_100d1 <= cnt_vsyn_100valid;
		cnt_vsyn_100valid_100d2 <= cnt_vsyn_100valid_100d1;
		
	end
	assign cmos_vsyn_100pos = 	cmos_vsyn_100d1 & ~cmos_vsyn_100d2;
	assign cnt_vsyn_100valid = cnt_vsyn == 1 ? 1 : 0;
	assign coms_vsyn_100pos = cnt_vsyn_100valid_100d1 & ~cnt_vsyn_100valid_100d2;
	//wire	rst_tmp =  coms_vsyn_100pos & ~cnt_vsyn_100valid;
	wire	rst_tmp = wr_sdram_add[21:9] >= 750 ? 1 : 0;
 */
	sync_module inst_sync
	(
		.CLK( clk_100M ),
		.RSTn( rst_100  ), //rst_100
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
		  .RSTn( rst_100 ), //rst_100
		  .Ready_Sig( Ready_Sig ),             // input - from inst_sync
		  .Column_Addr_Sig( Column_Addr_Sig ), // input - from inst_sync
		  .Row_Addr_Sig( Row_Addr_Sig ),       // input - from inst_sync
		  .Red_Sig( Red_Sig[4:0] ),      // output - to top
		  .Green_Sig( Green_Sig[5:0] ),  // output - to top+
		  .Blue_Sig( Blue_Sig[4:0] ),    // output - to top
		  .ps2_data_i( ),
		  .display_data(data_vga[15:0]),
		  .is_pic(is_pic)
	);


endmodule
