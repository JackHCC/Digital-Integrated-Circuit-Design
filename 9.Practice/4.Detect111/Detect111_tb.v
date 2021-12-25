`timescale 1ns/1ns
module Detect111_tb ();
    reg     X,
            clk,
            rst;
    wire    out;

    wire [11 : 0]   in;
    integer         i;


    assign in = 12'b1001_0111_0110;

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;

        @(posedge clk);
        rst = 0;

        for(i = 0; i < 12 ; i = i + 1) begin
            @(posedge clk);
            X = in >> i;
        end 

        #10;
        $finish;    
        
    end

    Detect111 u(.X(X),
                .clk(clk),
                .rst(rst),
                .out(out));
    
endmodule
