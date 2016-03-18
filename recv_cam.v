module recv_cam
(
	cmos_data,
	cmos_pclk,
	cmos_href,	
	cfg_done,
	data_16b,
	data_16b_en
	
);

	input[7:0] 		cmos_data;
	input			cmos_pclk;
	input			cfg_done;
	input			cmos_href;
	output[15:0]	data_16b;
	output			data_16b_en;	
	
	reg			done_d1,done_d2;
	reg			data_bit = 0;
	reg[15:0]	data_16b_r = 0;
	reg			data_16b_enr = 0;
	
	assign data_16b = data_16b_r;
	assign data_16b_en = data_16b_enr;
	
	always@(posedge cmos_pclk)begin
		done_d1 <= cfg_done;
		done_d2 <= done_d1;
		
	end
	always@(posedge cmos_pclk)begin
		if(done_d2 == 0) begin
			data_16b_r <= 0;
			data_16b_enr <= 0;
		end
		else begin
			if(cmos_href) begin
				if(data_bit == 0) begin
					data_16b_r[15:8] <= cmos_data[7:0];
					data_bit <= 1'b1;
					data_16b_enr <= 1'b0;
				end
				else if (data_bit == 1) begin
					data_16b_r[7:0] <= cmos_data[7:0];
					data_bit <= 1'b0;
					data_16b_enr <= 1'b1;
				end
			end
			else begin
				data_16b_r <= 0;
				data_16b_enr <= 0;
			end
		end
	end 

endmodule
