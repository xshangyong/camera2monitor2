module recv_cam
(
	cmos_data,
	cmos_pclk,
	cmos_href,
	cmos_vsyn,
	cfg_done,
	data_16b,
	data_16b_en
	
);

	input[7:0] 		cmos_data;
	input			cmos_pclk;
	input			cfg_done;
	input			cmos_href;
	input			cmos_vsyn;
	output[15:0]	data_16b;
	output			data_16b_en;	
	
	reg			done_d1,done_d2;
	reg			data_bit = 0;
	reg[15:0]	data_16b_r = 0;
	reg			data_16b_enr = 0;
	reg			cmos_vsyn_d1=0;
	reg			cmos_vsyn_d2=0;
	reg[7:0]	cnt_vsyn=0;
	reg			cmos_valid;
	wire vsyn_pos;	
	assign data_16b = data_16b_r;
	assign data_16b_en = data_16b_enr;
	
	always@(posedge cmos_pclk)begin
		done_d1 <= cfg_done;
		done_d2 <= done_d1;
		
	end
	always@(posedge cmos_pclk)begin
		if(done_d2 == 0 || cmos_vsyn == 1 || cmos_href == 0 || cmos_valid == 0) begin
			data_16b_r <= 0;
			data_16b_enr <= 0;
			data_bit <= 1'b0;
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
				data_16b_enr <= data_16b_enr;
			end
		end
	end 

	assign vsyn_pos = cmos_vsyn_d1 & ~cmos_vsyn_d2;
	always@(posedge cmos_pclk)begin
		cmos_vsyn_d1 <= cmos_vsyn;
		cmos_vsyn_d2 <= cmos_vsyn_d1;
		
		if(vsyn_pos == 1) begin
			if(cnt_vsyn == 30) begin
				cnt_vsyn <= cnt_vsyn;
				cmos_valid <= 1;
			end
			else begin
				cnt_vsyn <= cnt_vsyn + 1;
				cmos_valid <= 0; 
			end
		end

	end

	
	
endmodule
