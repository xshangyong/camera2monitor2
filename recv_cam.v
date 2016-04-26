module recv_cam
(
	cmos_data,
	cmos_pclk,
	cmos_href,
	cmos_vsyn,
	cfg_done,
	data_16b,
	data_16b_en,
	cnt_ref
);

	input[7:0] 		cmos_data;
	input			cmos_pclk;
	input			cfg_done;
	input			cmos_href;
	input			cmos_vsyn;
	input[31:0]		cnt_ref;
	output[15:0]	data_16b;
	output			data_16b_en;	
	
	reg			done_d1,done_d2;
	reg			data_bit = 0;
	reg[15:0]	data_16b_r = 0;
	reg			data_16b_enr = 0;
	reg			cmos_vsyn_d1=0;
	reg			cmos_vsyn_d2=0;
	reg[7:0]	cnt_vsyn=0;
	reg			cmos_valid = 0 ;
	reg[31:0]	cnt_ref_r = 0;
	reg			cmos_href_d1,cmos_href_d2;
	wire		cnt_less480;
	wire vsyn_pos;	
	assign data_16b = data_16b_r;
	assign data_16b_en = data_16b_enr;
	assign cnt_less480 = cnt_ref < 480 ? 1 : 0; 
	assign href_pos = ~cmos_href_d2 & cmos_href_d1;
	always@(posedge cmos_pclk)begin
		done_d1 <= cfg_done;			 // sim change  done_d1 <= cfg_done  1
		done_d2 <= done_d1;
		cmos_href_d1 <= cmos_href;
		cmos_href_d2 <= cmos_href_d1;
	end
	always@(posedge cmos_pclk)begin
		if(done_d2 == 0 || cmos_vsyn == 1 || cmos_valid == 0) begin //
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
				data_16b_r <= data_16b_r;
				data_16b_enr <= 0;
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
				cmos_valid <= 0;     // sim change  cmos_valid <= 0  1
			end
		end
		else begin
			cmos_valid <= cmos_valid;    	 // sim change  cmos_valid <= cmos_valid  1
		end
		
	end

	
	
endmodule
