`timescale 1ns/1ps
module FIFO64x8(
	input 	wire 	wr_en ,
			rd_en ,
			reset_n ,
			clk ,
	input 	wire 	[7 : 0] data_in ,
	output 	wire 	full ,
			empty ,
	output wire 	[7 : 0] data_o
	);

	reg 	[5 : 0] 	read_pointer; // it points the address where the data can be read
	reg 	[5 : 0] 	write_pointer; // it points the address where the data can be written
	wire 	[5 : 0] 	AA; // it points the address where the data can be read
	wire 	[5 : 0] 	AB; // it points the address where the data can be written
	wire 	[7 : 0] 	DB; // it points the address where the data can be written
	reg 	[5 : 0] 	num_FIFO; // it points the number of data in the FIFO

	S65NLLHS2PH64x8 uS65NLLHS2PH64x8 (
				.QA ( data_o ),
				.CLKA ( clk ),
				.CLKB ( clk ),
				.CENA ( CENA ),
				.CENB ( CENB ),
				.BWENB ( 8'b0 ),
				.AA ( AA ),
				.AB ( AB ),
				.DB ( DB )
				);
	assign #1 CENA = ! rd_en; // it shows if read is allowed
	assign #1 CENB = ! wr_en; // it shows if write is allowed
	assign #1 AA = read_pointer;
	assign #1 AB = write_pointer; 
	assign #1 DB = data_in;

	always@(posedge clk, negedge reset_n)
		if(reset_n == 1'b0) begin
			read_pointer <= 5'b0;
			write_pointer <= 5'b0;
			num_FIFO <= 0;
		end
		else begin
			if(CENA == 1'b0) begin
				read_pointer <= read_pointer + 1; // the head of the queue moves
				num_FIFO <= num_FIFO - 1;
			end
			if(CENB == 1'b0) begin
				write_pointer <= write_pointer + 1; // the tail of the queue moves
				num_FIFO <= num_FIFO + 1;
			end
		end
	assign full = num_FIFO >= 48;
	assign empty = num_FIFO <= 16;
endmodule

