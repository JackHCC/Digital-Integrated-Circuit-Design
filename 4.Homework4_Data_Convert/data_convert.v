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


module	data_convert_tb();
	reg				reset_n,
					start,
					clk,
					byte;
	reg		[7 : 0]	data_in;
	wire	[7 : 0]	data_o;
	wire			data_en;
	
	always #5   clk = !clk;

	initial begin
        clk     = 0;
        reset_n = 0;
        data_in  = 8'b0111_0011;
		start	= 0;
		byte	= 0;

	@(posedge clk) begin
		reset_n = 1;
		data_in  = 8'b1000_0100;
		start	= 1;
		byte	= 0;
		end
    	@(posedge clk) begin
		reset_n = 1;
		data_in  = 8'b0010_0001;
		start	= 1;
		byte	= 1;
		end
	@(posedge clk) begin
		reset_n = 1;
		data_in  = 8'b0110_1001;
		start	= 1;
		byte	= 1;
		end
	@(posedge clk) begin
		reset_n = 1;
		data_in  = 8'b1010_0101;
		start	= 1;
		byte	= 0;
		end
	@(posedge clk) begin
		reset_n = 1;
		data_in  = 8'b1010_0101;
		start	= 1;
		byte	= 0;
		end
	@(posedge clk) begin
		reset_n = 1;
		data_in  = 8'b1010_0101;
		start	= 1;
		byte	= 1;
		end
	@(posedge clk) begin
		reset_n = 1;
		data_in  = 8'b1010_0101;
		start	= 1;
		byte	= 1;
		end
	$finish;
    	end

data_convert u(	.reset_n(reset_n),
		.clk(clk),
		.start(start),
		.byte(byte),
		.data_in(data_in),
		.data_o(data_o),
		.data_en(data_en));

endmodule
