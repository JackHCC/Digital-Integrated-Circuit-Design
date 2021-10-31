`timescale 1ns  / 10 ps

module CLA_4_tb ();

	reg  [3:0] 	A=0, B=0;
	wire [3:0]	Sum ,Generate ,Propogate;
	reg 		Cin;

initial begin : Cin_TB

               Cin = 0;
          #10  Cin = 1'b1;
          #10  Cin = 1'b0;

          #10  Cin = 1'b1;
          #10  Cin = 1'b0;

          #10  Cin = 1'b1;
          #10  Cin = 1'b0;

          #10  Cin = 1'b1;

        end


initial begin : A_TB
               A = 0;
          #10  A = 4'hF;
          #10  A = 4'h0;

          #10  A = 4'h8;
          #10  A = 4'h0;

          #10  A = 4'hF;
          #10  A = 4'h0;

          #10  A = 4'h1;

        end

initial begin : B_TB
              B = 0;
          #10 B = 4'h1;
          #10 B = 4'h0;

          #10 B = 4'h8;
          #10 B = 4'h0;

          #10 B = 4'h8;
          #10 B = 4'h0;

          #10 B = 4'h2;
        end

        
CLA_4 U1 (Cin, A, B, Sum, Generate ,Propogate);

endmodule



/*`timescale 1ns / 1ps

module CLA_tb();
	reg   [3:0]       A     ;
	reg   [3:0]       B     ;
	reg               Cin   ;
	wire  [3:0]       S     ;
	wire              Cout  ;
 
initial begin
	A=0;
	B=0;
	Cin = 0;
	#10
	A = 4'd10;
	B = 4'd5 ;
	# 20
	B = 4'd6;
	# 10
	Cin = 1;
	#30
	A = 4'd4;
	B = 4'd3;
	#20
	Cin = 0;
end

	Carry_Lookahead_Adder uut(
	.A     (A    ),
	.B     (B    ),
	.Cin   (Cin  ),
	.S     (S    ),
	.Cout  (Cout )
	);
endmodule*/