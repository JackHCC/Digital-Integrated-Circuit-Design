`timescale	10ns/1ns
module data_convert(
	input	wire		reset_n,
				start,
				clk,
				byte,
	input	reg  [7 : 0]	data_in,
	output	reg  [7 : 0]	data_o,
	output	reg		data_en
);

	reg [3 : 0]	buffer;
	reg		flag;

	
	always@(posedge clk)	
	begin
		if(!reset_n)	
		begin
			buffer = 0;
			data_en = 0;
			flag = 0;
		end

		else	
		begin
			
			if(!start) 
			begin
				data_o	= 0;
				data_en = 0;
			end
			else 
			begin
				if(byte) 
				begin
					if(!flag)	
					begin
						data_o[7:0] = data_in[7:0];
						data_en = 1;
					end
					else 
					begin
						data_o[7:0] = {buffer[3:0], data_in[7:4]};
						buffer[3:0] = data_in[3:0];
						data_en = 1;
						flag = 1;
					end
				end
				else 
				begin
					if(!flag)	
					begin
						buffer[3:0] = data_in[3:0];
						data_en = 0;
						data_o = 0;
						flag = 1;
					end
					else	
					begin
						data_o[7:0] = {buffer[3:0], data_in[3:0]};
						buffer[3:0] = 0;
						data_en = 1;
						flag = 0;
					end
				end
			end			

		end

	end	

endmodule



