`timescale 1ns  / 10 ps

module ALU_UNIT ( input wire 		opA	, 	//???A
					opB 	, 	//???B
		   input wire 	[3 : 0] S 	, 	//????????
		   input wire 		M 	, 	//????????
			      		Cin 	, 	//??????
		   output reg 		DO 	, 	//????
		   output reg 		C 		//????
);
	wire	item0, item1, item2, item3;
	reg	p, g;
	

	assign	item0	= ~opA & ~opB;
	assign	item1	= ~opA &  opB;
	assign	item2	=  opA & ~opB;
	assign	item3	=  opA &  opB;

always@(*)
begin
	p 	= ~((S[3] & item3) | (S[2] & item2) | (S[1] & item1) | (S[0] & item0));
	g	= (S[3] & item3) | (S[2] & item2) | ~M;
	DO	= p ^ Cin;
	C	= g | (p & Cin);
end

endmodule


//	Test 1 bit
module ALU_UNIT_tb ();

	reg		opA,opB,M,Cin;
	wire		DO,C;
	reg 	[3 : 0]	S;


initial	begin:	S_TB
		opA	= 1'b1;
		opB	= 1'b0;
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


	#20	opA	= 1'b1;
		opB	= 1'b1;
		M	= 1'b1;
		Cin	= 1'b0;
		S	= 4'b1001;

	#20	Cin	= 1'b1;
		S	= 4'b0110;
	
	end

ALU_UNIT U1 (opA,opB,S,M,Cin,DO,C);

endmodule
