`timescale 1ns/1ns
module Counter_tb ();
    reg             clk,
                    rst;
    wire    [2 : 0] Y;


    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;

        #10 rst = 0;

        #100;

        $finish;
    end

    Counter uc( .clk(clk),
                .rst(rst),
                .Y(Y));
endmodule