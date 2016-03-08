module camera_cfg
(
	clk_100,
	rst_100,
	sclk,
	sda
);

	input 		clk_100;
	input 		rst_100;
	output 		sclk;
	inout		sda;
	
	wire		i2c_ack;
	reg			i2c_req = 0;
	reg[31:0]	cfg_data = 0;
	reg[31:0]	cfg_send = 0;
	reg[6:0]	cnt_cfg = 0;
	reg[4:0]	n_state = 0;	
	reg[4:0]	c_state = 0;	
	
	parameter	rst 	= 0;
	parameter	idle 	= 1;
	parameter	req 	= 2;
	parameter	ack 	= 3;
	
	send_i2c	inst_sendi2c(
		.clk_100	(clk_100),
		.rst_100    (rst_100),
		.sclk       (sclk),
		.sda        (sda),
		.cfg_data   (cfg_send),
		.i2c_req    (i2c_req),
		.i2c_ack    (i2c_ack)
	);
	
	always @(posedge clk_100) begin
		if(!rst_100) begin
			c_state <= rst;
		end
		else begin
			c_state <= n_state;
		end
	end
	
	always @(*) begin
		if(!rst_100) begin
			n_state <= rst;
		end
		else begin
			case(c_state)
				rst : begin
					n_state = idle;
				end
				idle : begin
					if(cnt_cfg < 3) begin  
						n_state = req;
					end
					else begin
						n_state = n_state;
					end
				end
				req : begin
					n_state = ack;
				end
				ack : begin
					if(i2c_ack == 1) begin
						n_state = idle;
					end
				end
			endcase
		end
	end	
	
	always @(posedge clk_100) begin
		if(!rst_100) begin
			i2c_req <= 0;
			cnt_cfg <= 0;
		end
		else begin
			case(c_state)
				rst : begin
					i2c_req <= 0;
				end
				idle : begin
					i2c_req <= 0;
				end
				req : begin
					i2c_req <= 1;
					cnt_cfg <= cnt_cfg + 1;
					cfg_send <= cfg_data;
				end
				ack : begin
					i2c_req <= 0;
				end	
			endcase
		end
	end
	
	always @(*) begin
		if(!rst_100) begin
			cfg_data = 0;
		end
		else begin
			case(cnt_cfg)
				0 :	cfg_data = 32'h5555_aaaa;
				1 :	cfg_data = 32'h4444_bbbb;
				2 :	cfg_data = 32'h3333_cccc;
				default :	cfg_data = 32'h1111_1111;
			endcase
		end
	end
endmodule
