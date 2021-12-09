`timescale 1ns/1ps
module mod_tb();
	reg		clk,
			rst_n,
			rdy;
	reg	[7 : 0]	data_in;
	wire	[4 : 0] dmod;
	wire		rd,
			mod_en;

	integer	i, j;

	always	#5	clk = !clk;

	initial begin
		clk 	<= 0;
		rst_n	<= 0;
		rdy	<= 1;
		data_in	<= 2'h00;
	

	@(posedge clk)
		rst_n <= 1;
		rdy <= 0;

	@(posedge clk)
		
		data_in <= 8'b0000_0001;


	for(i = 0; i < 16; i = i + 1) begin
		@(posedge clk)
			data_in <= data_in + 1;
	end

	// for(j = 0; j < 8; j = j + 1) begin
	// 	@(posedge clk);
	// end

	#50 $finish;
	end

	mod u(	.clk(clk),
		.rst_n(rst_n),
		.rdy(rdy),
		.data_in(data_in),
		.dmod(dmod),
		.rd(rd),
		.mod_en(mod_en)		
	);

endmodule

