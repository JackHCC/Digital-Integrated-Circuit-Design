`timescale 1ns/1ns
module Tran2(
    input wire      Rst,
		            Clk, 
		            start,
		            byt,
    input wire[7:0] DB,
    output reg      Out_en ,
    output reg[7:0] Out  
);

    reg[3:0]   DB_reg;    //hold the  valid bits 
    reg        empty;       //there is data in DB_reg, 0 no, 1 yes

    always@( posedge Clk , negedge Rst)
        if( !Rst )
	        empty  <= 1'b0 ;
        else if( start )
	        if ( empty == 1'b0 && byt == 1'b0)
		        empty <= 1'b1;
	        else if ( empty == 1'b1 && byt == 1'b0)
		        empty <= 1'b0;

    always @( posedge Clk )
        if( start )
            if ( empty == 1'b0 && byt == 1'b0)
                DB_reg <= DB[3 : 0];
            else if(empty == 1'b1 && byt == 1'b1)
                DB_reg <= DB[3 : 0];

    always @(*)
        if( start) 
            if( empty == 1'b0)
                if ( byt == 1'b1) begin
                    Out = DB;
                    Out_en = 1'b1;
                end 
                else begin
                    Out = 'bx;
                    Out_en = 1'b0;
                end
        else
            if ( byt == 1'b1) begin
                Out = {DB_reg, DB[7:4]};
                Out_en = 1'b1;
            end 
            else begin
                Out = {DB_reg, DB[3:0]};
                Out_en = 1'b1;
            end
        else begin
            Out = DB;
            Out_en = 1'b0;
        end
endmodule


