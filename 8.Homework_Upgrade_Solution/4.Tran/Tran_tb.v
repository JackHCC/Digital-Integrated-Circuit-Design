`timescale 1ns/1ns
module Tran_tb ();
    reg  [7 : 0]    data_in;
    reg             reset_n,
                    clk,
                    start,
                    byte;
    wire [7 : 0]    data_o;
    wire            data_en;


    always #5 clk   = ~clk;
    initial begin
        clk     = 0;
        reset_n = 0;
        data_in = 0;
        start   = 0;
        byte    = 0;

        @(posedge clk);
        reset_n = 1;

        @(posedge clk);
        data_in = 8'b1010_1010;

        @(posedge clk);
        start   = 1;
        data_in = 8'b1010_1010;

        @(posedge clk);
        byte    = 1;
        data_in = 8'b1111_0000;

        @(posedge clk);
        byte    = 0;
        data_in = 8'b0011_0011;

        @(posedge clk);
        byte    = 1;
        data_in = 8'b1111_0011;
        #10;
        $finish;

    end

    // Tran utran( .clk(clk),
    //             .reset_n(reset_n),
    //             .start(start),
    //             .byte(byte),
    //             .data_in(data_in),
    //             .data_o(data_o),
    //             .data_en(data_en));

    // Test Tran2
    Tran2 utran( .Clk(clk),
                .Rst(reset_n),
                .start(start),
                .byt(byte),
                .DB(data_in),
                .Out(data_o),
                .Out_en(data_en));


endmodule