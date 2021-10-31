`timescale 1ns  / 10 ps

// four bits CLA Module
module CLA_4 ( 	input  		Cin,				
        	input  	[3:0] 	A, B,
        	output 	[3:0] 	Sum,Generate ,Propogate);

	wire 	[3:0] 	Carry,g,p; 

	assign Sum        	= (A ^ B^ Carry);
	assign g  		= (A & B);                 
	assign p  		= (A ^ B);				   
	assign Generate     	=  g;				   
	assign Propogate    	=  p; 

	assign Carry[0] =     Cin ;
	assign Carry[1] =  (( Cin & p[0])                    |  g[0]);
	assign Carry[2] =  (( Cin & p[0]&p[1] )              | (g[0]&p[1])               |  g[1]);
	assign Carry[3] =  (( Cin & p[0]&p[1]&p[2])          | (g[0]&p[1]&p[2])          | (g[1]&p[2])           |  g[2] );

endmodule
