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
	output reg	sclk = 1;
	
	
	wire[7:0]	cnt_i2c;
	reg[7:0]	cnt_i2c_r 	= 0;
	reg[4:0]	n_state 	= 0;	
	reg[4:0]	c_state 	= 0;	
	reg[15:0]	cnt_sclk 	= 0;
	reg			sclk_pulse 	= 0;
	reg			sda_r 		= 1;

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
					if(cnt_i2c_r == 89 && cnt_sclk >= 4999) begin
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
	assign cnt_i2c = cnt_i2c_r >= 3 ? cnt_i2c_r - 3 : 0;
	always @(posedge clk_100) begin
		if(!rst_100) begin
			i2c_ack <= 0;
			cnt_i2c_r <= 0;
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
						cnt_i2c_r <= cnt_i2c_r + 1;
					end
					if(cnt_i2c >=0 && cnt_i2c <=3) begin
						sclk <= 1;
					end
					else if(cnt_i2c == 4 || cnt_i2c == 5 || cnt_i2c == 6) begin
						sclk <= 0;
					end
					else if(cnt_i2c == 78 || cnt_i2c == 79) begin
						sclk <= 0;
					end
					else if(cnt_i2c >= 80 && cnt_i2c <= 82) begin
						sclk <= 1;
					end
					else if(cnt_i2c <= 80)begin
						sclk <= cnt_i2c[0];
					end
					case(cnt_i2c)
						0  :	sda_r<=1;
						2  :	sda_r<=0;
						4  :	sda_r<=0;
						6  :	sda_r<=cfg_data[31];
						8  :	sda_r<=cfg_data[30];
						10 :	sda_r<=cfg_data[29];
						12 :	sda_r<=cfg_data[28];
						14 :	sda_r<=cfg_data[27];
						16 :	sda_r<=cfg_data[26];
						18 :	sda_r<=cfg_data[25];
						20 : 	sda_r<=cfg_data[24];
						22 :	sda_r<=1; // slave ack
						24 :	sda_r<=cfg_data[23];
						26 :	sda_r<=cfg_data[22];
						28 :	sda_r<=cfg_data[21];
						30 :	sda_r<=cfg_data[20];
						32 :	sda_r<=cfg_data[19];
						34 :	sda_r<=cfg_data[18];
						36 : 	sda_r<=cfg_data[17];
						38 :	sda_r<=cfg_data[16];
						40 :	sda_r<=1; // slave ack
						42 :	sda_r<=cfg_data[15];
						44 :	sda_r<=cfg_data[14];
						46 :	sda_r<=cfg_data[13];
						48 :	sda_r<=cfg_data[12];
						50 :	sda_r<=cfg_data[11];
						52 :	sda_r<=cfg_data[10];
						54 :	sda_r<=cfg_data[9];
						56 : 	sda_r<=cfg_data[8];
						58 :	sda_r<=1; // slave ack
						60 :	sda_r<=cfg_data[7];
						62 :	sda_r<=cfg_data[6];
						64 :	sda_r<=cfg_data[5];
						66 :	sda_r<=cfg_data[4];
						68 :	sda_r<=cfg_data[3];
						70 :	sda_r<=cfg_data[2];
						72 :	sda_r<=cfg_data[1];
						74 :	sda_r<=cfg_data[0];
						76 : 	sda_r<=1; // slave ack
						78 : 	sda_r<=0; 
						80 : 	sda_r<=0; 
						82 : 	sda_r<=1; 
					endcase
				end	
				ack : begin
					i2c_ack <= 1;
					cnt_i2c_r <= 0;
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
