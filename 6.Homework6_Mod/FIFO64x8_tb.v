`timescale 1ns/1ps
module FIFO64x8_tb();
	reg 		clk,
			rst_n,
			read_en,
			write_en;
	reg 	[7 : 0]	data_in;
	wire	[7 : 0] data_out;
	wire		empty,
			full;


	always	#5	clk = !clk;

	integer i,j;
	
	initial begin
		clk = 0;
		@(posedge clk);
			rst_n = 1'b0;

		@(posedge clk);
			rst_n = 1'b1;

		@(posedge clk); 
			rst_n 	= 1'b1;
			read_en = 1'b0;
			write_en= 1'b1;
			data_in	= 2'h00;
	
		
		for(j=0; j < 3; j=j+1)
			for(i=0; i < 16; i=i+1) begin
			@(posedge clk);
				data_in <= data_in + 1;
			end

		@(posedge clk);
			read_en <= 1'b1;
			write_en<= 1'b0;
			//while(!empty)
				//@(negedge clk);	

		for(j=0; j < 3; j=j+1)
			for(i=0; i < 16; i=i+1)
				@(posedge clk);
					data_in <= 0;

		

		#20 $finish;
	end

	FIFO64x8 u(
		.clk(clk),
		.reset_n(rst_n),
		.rd_en(read_en),
		.wr_en(write_en),
		.data_in(data_in),
		.data_o(data_out),
		.empty(empty),
		.full(full));

endmodule	

