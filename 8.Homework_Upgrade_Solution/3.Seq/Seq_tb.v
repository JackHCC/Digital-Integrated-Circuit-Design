`timescale 1ns/1ns
module Seq_tb ();
    reg     clk,
            clr,
            A,
            B;
    wire    Z;


    reg [31 : 0]    din = 32'b1100_0111_0011_1011_1001_1011_0001_1110;
    integer         i;

    always #5   clk = ~clk;

    initial begin
        clk = 0;
        clr = 1;
        A   = 0;
        B   = 0;
        
        @(posedge clk);
        clr = 0;

        for(i = 0; i < 16; i = i + 1) begin
            @(posedge clk);
            B   = din[31];
            A   = din[30];
            @(negedge clk);
            din = din << 2;
        end

        #10;
        $finish;
    end

    Seq useq(   .clk(clk),
                .clr(clr),
                .A(A),
                .B(B),
                .Z(Z));
endmodule