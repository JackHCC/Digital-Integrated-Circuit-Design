`timescale 1ns  / 10 ps

module CLA_32_4 (   input  [31:0] a_inp, 
                    input  [31:0] b_inp,
                    output reg [31:0] s_out,
                    output reg        c_out,
                    input         clock,
                    input         reset);

	wire       Cin_1        ,Cin_2          ,Cin_3          ,Cin_4          ,Cin_5          ,Cin_6          ,Cin_7          ,Cin_8;
	wire       Cout_1       ,Cout_2         ,Cout_3         ,Cout_4         ,Cout_5         ,Cout_6         ,Cout_7         ,Cout_8;
	reg  [3:0] A_1          ,A_2            ,A_3            ,A_4            ,A_5            ,A_6            ,A_7            ,A_8;
	reg  [3:0] B_1          ,B_2            ,B_3            ,B_4            ,B_5            ,B_6            ,B_7            ,B_8;
	wire [3:0] Sum_1        ,Sum_2          ,Sum_3          ,Sum_4          ,Sum_5          ,Sum_6          ,Sum_7          ,Sum_8;
	wire [3:0] Generate_1   ,Generate_2     ,Generate_3     /*,Generate_4*/     ,Generate_5     ,Generate_6     ,Generate_7     /*,Generate_8*/;
	wire [3:0] Propogate_1  ,Propogate_2    ,Propogate_3    /*,Propogate_4*/    ,Propogate_5    ,Propogate_6    ,Propogate_7    /*,Propogate_8*/;

	wire [3:0] Ignore_1 ,Ignore_2 ,Ignore_3 ,Ignore_4;
	wire [15:0] Propogate_4,Generate_4,Propogate_8,Generate_8;

	assign {Generate_8 ,Generate_4 }   = ({A_8,A_7,A_6,A_5,A_4,A_3,A_2,A_1} & {B_8,B_7,B_6,B_5,B_4,B_3,B_2,B_1});
	assign {Propogate_8,Propogate_4}   = ({A_8,A_7,A_6,A_5,A_4,A_3,A_2,A_1} ^ {B_8,B_7,B_6,B_5,B_4,B_3,B_2,B_1});
 

	assign Cin_1 = 0;
	assign Cin_2 = Cout_1;
	assign Cin_3 = Cout_2;
	assign Cin_4 = Cout_3;
	assign Cin_5 = Cout_4;
	assign Cin_6 = Cout_5;
	assign Cin_7 = Cout_6;
		assign Cin_8 = Cout_7;

always@(posedge clock or posedge reset) 
begin
    if (reset) 
        begin
            s_out <= 'b0;
            c_out <= 'b0;

            A_1   <= 'b0;
            A_2   <= 'b0;
            A_3   <= 'b0;
            A_4   <= 'b0;
            A_5   <= 'b0;
            A_6   <= 'b0;
            A_7   <= 'b0;
            A_8   <= 'b0;

            B_1   <= 'b0;
            B_2   <= 'b0;
            B_3   <= 'b0;
            B_4   <= 'b0;
            B_5   <= 'b0;
            B_6   <= 'b0;
            B_7   <= 'b0;
            B_8   <= 'b0;

        end
    else 
        begin
            {A_8,A_7,A_6,A_5,A_4,A_3,A_2,A_1} <= a_inp;
            {B_8,B_7,B_6,B_5,B_4,B_3,B_2,B_1} <= b_inp;
            s_out <= {Sum_8,Sum_7,Sum_6,Sum_5,Sum_4,Sum_3,Sum_2,Sum_1};
            c_out <= Cout_8;
        end
end


CLA_4 U1 (Cin_1, A_1, B_1, Sum_1, Generate_1 ,Propogate_1 );    // CLA Adder with first level carry generator using 4 bit adder group
CLA_4 U2 (Cin_2, A_2, B_2, Sum_2, Generate_2 ,Propogate_2 );
CLA_4 U3 (Cin_3, A_3, B_3, Sum_3, Generate_3 ,Propogate_3 );
CLA_4 U4 (Cin_4, A_4, B_4, Sum_4, Ignore_1   ,Ignore_2    );

CLA_4 U5 (Cin_5, A_5, B_5, Sum_5, Generate_5 ,Propogate_5 );
CLA_4 U6 (Cin_6, A_6, B_6, Sum_6, Generate_6 ,Propogate_6 );
CLA_4 U7 (Cin_7, A_7, B_7, Sum_7, Generate_7 ,Propogate_7 );
CLA_4 U8 (Cin_8, A_8, B_8, Sum_8, Ignore_3   ,Ignore_4    );

carry_out_4 U9  (Cin_1, Generate_1 ,Propogate_1, Cout_1);       // CLA Adder with second level carry generator using 4 bit adder group
carry_out_4 U10 (Cin_2, Generate_2 ,Propogate_2, Cout_2);
carry_out_4 U11 (Cin_3, Generate_3 ,Propogate_3, Cout_3);
//carry_out_4 U12 (Cin_4, Generate_4 ,Propogate_4, Cout_4);
carry_out_16 U12 (Cin_1, Generate_4 ,Propogate_4, Cout_4);           // 3rd level CLA 


carry_out_4 U13 (Cin_5, Generate_5 ,Propogate_5, Cout_5);
carry_out_4 U14 (Cin_6, Generate_6 ,Propogate_6, Cout_6);
carry_out_4 U15 (Cin_7, Generate_7 ,Propogate_7, Cout_7);
//carry_out_4 U16 (Cin_8, Generate_8 ,Propogate_8, Cout_8);
carry_out_16 U16 (Cin_5, Generate_8 ,Propogate_8, Cout_8);           // 3rd level CLA 


endmodule
