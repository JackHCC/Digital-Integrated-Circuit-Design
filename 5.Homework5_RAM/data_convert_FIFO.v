`timescale	10ns/1ns
module data_convert_FIFO #(
	parameter 	DEPTH = 6,
  	  		WIDTH = 8,
  	   		MAX_COUNT = (1 << DEPTH)
	)(
	input	wire		reset_n,
				start,
				clk,
				byte,
				read_en,
	input	wire  [7 : 0]	data_in,
	output 	wire[WIDTH-1:0] data_out,       
  	output 	wire 	        empty,        	
  	output 		        full
);

wire  	[7 : 0]		data_o;      
wire			data_convert_en;     


data_convert u1(.reset_n(reset_n),
		.clk(clk),
		.start(start),
		.byte(byte),
		.data_in(data_in),
		.data_o(data_o),
		.data_en(data_convert_en));


FIFO64x8 u2(	.clk(clk),
		.rst_n(reset_n),
		.read_en(read_en),
		.write_en(data_convert_en),
		.data_in(data_o),
		.data_out(data_out),
		.empty(empty),
		.full(full));

endmodule
