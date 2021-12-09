`timescale 1ns/1ps
module data_ram #(
	parameter 	DEPTH = 6,
  	  		    WIDTH = 8,
  	   		    MAX_COUNT = (1 << DEPTH)
	)(
	input	wire		reset_n,
				        start,
				        clk,
				        byte,
				        //read_en,
	input	wire  [7 : 0]	data_in,
	output  wire  [4 : 0]   dmod,
    output  wire        mod_en,
                        rd,
                        full
);

wire  	[WIDTH-1:0]	data_o;      
wire			    data_convert_en;   

wire    [WIDTH-1:0] data_out;       
wire 	            empty;        	
                    //full;


data_convert u1(.reset_n(reset_n),
		.clk(clk),
		.start(start),
		.byte(byte),
		.data_in(data_in),
		.data_o(data_o),
		.data_en(data_convert_en));


FIFO64x8 u2(	.clk(clk),
		.reset_n(reset_n),
		.rd_en(rd), 
		.wr_en(data_convert_en),
		.data_in(data_o),
		.data_o(data_out),
		.empty(empty),
		.full(full));

mod u3(	.clk(clk),
		.rst_n(reset_n),
		.rdy(empty),
		.data_in(data_out),
		.dmod(dmod),
		.rd(rd),
		.mod_en(mod_en));

endmodule
