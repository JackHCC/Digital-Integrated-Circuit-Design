`timescale	10ns/1ns

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
