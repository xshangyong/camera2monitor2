module send_i2c
(
	clk_100,
	rst_100,
	sclk,
	sda,
	cfg_data,
	i2c_req,
	i2c_ack
);

	input 		clk_100;
	input 		rst_100;
	inout		sda;
	input[31:0]	cfg_data;
	input		i2c_req;
	output reg	i2c_ack = 0;
	output reg	sclk = 0;
	
	
	reg[7:0]	cnt_i2c 	= 0;
	reg[4:0]	n_state 	= 0;	
	reg[4:0]	c_state 	= 0;	
	reg[15:0]	cnt_sclk 	= 0;
	reg			sclk_pulse 	= 0;
	reg			sda_r 		= 0;

	parameter	rst 	= 0;
	parameter	idle 	= 1;
	parameter	req 	= 2;
	parameter	send 	= 3;
	parameter	ack 	= 4;
	
	assign sda = sda_r ? 1'bz : 0;

	
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
					if(i2c_req == 1) begin  
						n_state = send;
					end
					else begin
						n_state = n_state;
					end
				end
				send : begin
					if(cnt_i2c == 73 && cnt_sclk >= 4999) begin
						n_state = ack;
					end
					else begin
						n_state = n_state;
					end
				end
				ack : begin
					n_state = idle;
				end
			endcase
		end
	end	
	
	always @(posedge clk_100) begin
		if(!rst_100) begin
			i2c_ack <= 0;
			cnt_i2c <= 0;
		end
		else begin
			case(c_state)
				rst : begin
					i2c_ack <= 0;
				end
				idle : begin
					i2c_ack <= 0;
				end
				send : begin
					i2c_ack <= 0;
					if(sclk_pulse == 1) begin
						cnt_i2c <= cnt_i2c + 1;
					end
					if(cnt_i2c == 0 || cnt_i2c == 72 || cnt_i2c == 73) begin
						sclk <= 1;
					end
					else if(cnt_i2c == 71) begin
						sclk <= 0;
					end
					else begin
						sclk <= cnt_i2c[0];
					end
					case(cnt_i2c)
						0:	sda_r<=1;
						1:	sda_r<=0;
						2:	sda_r<=cfg_data[31];
						4:	sda_r<=cfg_data[30];
						6:	sda_r<=cfg_data[29];
						8:	sda_r<=cfg_data[28];
						10:	sda_r<=cfg_data[27];
						12:	sda_r<=cfg_data[26];
						14:	sda_r<=cfg_data[25];
						16: sda_r<=1; // slave ack
						18:	sda_r<=cfg_data[24];
						20:	sda_r<=cfg_data[23];
						22:	sda_r<=cfg_data[22];
						24:	sda_r<=cfg_data[21];
						26:	sda_r<=cfg_data[20];
						28:	sda_r<=cfg_data[19];
						30:	sda_r<=cfg_data[18];
						32: sda_r<=cfg_data[17];
						34:	sda_r<=1; // slave ack
						36:	sda_r<=cfg_data[16];
						38:	sda_r<=cfg_data[15];
						40:	sda_r<=cfg_data[14];
						42:	sda_r<=cfg_data[13];
						44:	sda_r<=cfg_data[12];
						46:	sda_r<=cfg_data[11];
						48:	sda_r<=cfg_data[10];
						50:	sda_r<=cfg_data[9];
						52: sda_r<=1; // slave ack
						54:	sda_r<=cfg_data[8];
						56:	sda_r<=cfg_data[7];
						58:	sda_r<=cfg_data[6];
						60:	sda_r<=cfg_data[5];
						62:	sda_r<=cfg_data[4];
						64:	sda_r<=cfg_data[3];
						66:	sda_r<=cfg_data[2];
						68:	sda_r<=cfg_data[1];
						70:	sda_r<=cfg_data[0];
						71: sda_r<=0; 
						72: sda_r<=0; 
						73: sda_r<=1; 
					endcase
				end	
				ack : begin
					i2c_ack <= 1;
					cnt_i2c <= 0;
				end	
			endcase
		end
	end
	
	always @(posedge clk_100) begin
		if(!rst_100) begin
			cnt_sclk <= 0;
			sclk_pulse <= 0;
		end
		else begin
			if(i2c_req == 1) begin
				cnt_sclk <= 0;
			end
			else if(cnt_sclk == 4999) begin
				cnt_sclk <= 0;
				sclk_pulse <= 1;
			end
			else begin
				cnt_sclk <= cnt_sclk + 1;
				sclk_pulse <= 0;
			end
		end
	end
endmodule
