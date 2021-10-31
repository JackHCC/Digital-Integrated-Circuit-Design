`timescale 1ns  / 10 ps

module CLA_32_4_tb ();

	reg  [31:0] A=0, B=0 ;
	wire [31:0] Sum;
	wire Cout;
	reg  reset,clock;


initial begin : A_TB
               A = 0;
          #10  A = 32'h00FF_00FF;
          #30  A = 32'h0000_0000;   // Making input = 0 so that next transition can be noted

          #30  A = 32'h8080_8080;
          #30  A = 32'h0000_0000;   // Making input = 0 so that next transition can be noted

          #30  A = 32'h0000_00FF;
          #30  A = 32'h0000_0000;   // Making input = 0 so that next transition can be noted

          #30  A = 32'h1111_1111;   

        end

initial begin : B_TB
              B = 0;
          #10 B = 32'hFF00_FF01;
          #30 B = 32'h0000_0000;   // Making input = 0 so that next transition can be noted

          #30 B = 32'h8080_8080;
          #30 B = 32'h0000_0000;   // Making input = 0 so that next transition can be noted

          #30 B = 32'hFFFF_FF80;
          #30 B = 32'h0000_0000;   // Making input = 0 so that next transition can be noted

          #30 B = 32'h2222_2222;
        end



initial begin : reset_TB
               reset = 0; 
           #2  reset = 1;
           #5  reset = 0;

           #55  reset = 1;
           #5   reset = 0;

           #55  reset = 1;
           #5   reset = 0;

           #55  reset = 1;
           #5   reset = 0;

           #65 $finish;
        end

initial begin : clock_TB
                clock = 0;
            #5  clock = 1;
  forever   #5  clock = ~clock;
        end
        
CLA_32_4 U1 (A, B, Sum, Cout, clock, reset);

initial begin 
            $monitor("TIME :",$time,"   HEX VALUES : a_inp = %h    b_inp = %h    s_out = %h    c_out = %h",A,B,Sum,Cout);
        end

initial begin
            $dumpfile("CLA_32_4_tb.vcd");
            $dumpvars(0,CLA_32_4_tb);
end 

endmodule
