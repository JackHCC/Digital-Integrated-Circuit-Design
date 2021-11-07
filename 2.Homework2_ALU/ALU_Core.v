`timescale 1ns  / 10 ps

module ALU_Core #( parameter  		  n = 32) 
		 ( input wire 	[n-1 : 0] opA	, 	//???A
					  opB 	, 	//???B
		   input wire 	[3 : 0]   S 	, 	//????????
		   input wire 		  M 	, 	//????????
			      		  Cin 	, 	//??????
		   output reg 	[n-1 : 0] DO 	, 	//????
		   output reg 		  C 	, 	//????
					  V 	, 	//????????
					  N 	, 	// DO???????
					  Z 		//DO??0????
);
	wire	[n : 0]		c;
	wire	[n-1 : 0]	D;

	assign	c[0]	= Cin;

generate
	genvar i;
	for(i=0; i<n; i=i+1) begin: u
		ALU_UNIT unit (opA[i], opB[i], S, M, c[i], D[i], c[i+1]);
	end
endgenerate

initial begin
	C	<= 0;
	V	<= 0;
	N	<= 0;
	Z	<= 0;
end

always@(*)
begin
	DO	= D;
	C	= c[n];
	N	= DO[n-1];
	Z	= ~(| DO);
	V	= c[n] ^ c[n-1];
end

endmodule



// Test	32 bit
module ALU_Core_tb();
	parameter	n	=32;

	reg	[n-1 : 0]	opA,opB;
	reg			M,Cin;
	wire	[n-1 : 0]	DO;
	wire			C,V,N,Z;
	reg 	[3 : 0]		S;

initial begin: S_TB
		opA	= 32'hFFFF_FFFF;
		opB	= 32'h0000_0000;

		M	= 1'b0;
		Cin	= 1'b1;
		S	= 4'b0000;
	#10	S	= 4'b0001;
	#10	S	= 4'b0010;
	#10	S	= 4'b0011;
	#10	S	= 4'b0100;
	#10	S	= 4'b0101;
	#10	S	= 4'b0110;
	#10	S	= 4'b0111;
	#10	S	= 4'b1000;
	#10	S	= 4'b1001;
	#10	S	= 4'b1010;
	#10	S	= 4'b1011;
	#10	S	= 4'b1100;
	#10	S	= 4'b1101;
	#10	S	= 4'b1110;
	#10	S	= 4'b1111;


	#20	opA	= 32'h7FFF_FFFF;
		opB	= 32'h7FFF_FFFF;
		M	= 1'b1;
		Cin	= 1'b0;
		S	= 4'b1001;

	#20	Cin	= 1'b1;
		S	= 4'b0110;

	#20	opA	= 32'hFFFF_FFFF;
		opB	= 32'hFFFF_FFFF;
		M	= 1'b1;
		Cin	= 1'b0;
		S	= 4'b1001;

	#20	Cin	= 1'b1;
		S	= 4'b0110;


	#20	opA	= 32'h000F_FFFF;
		opB	= 32'h000F_FFFF;
		M	= 1'b1;
		Cin	= 1'b0;
		S	= 4'b1001;

	#20	Cin	= 1'b1;
		S	= 4'b0110;

end

ALU_Core #(n) Core (	.opA(opA), 
			.opB(opB),
			.S(S),
			.M(M),
			.Cin(Cin),
			.DO(DO),
			.C(C),
			.V(V),
			.N(N),
			.Z(Z));
endmodule
