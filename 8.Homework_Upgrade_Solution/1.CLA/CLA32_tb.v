`timescale 1ns/1ns
module CLA32_tb ();
    reg [31 : 0]    a_in,
                    b_in;
    reg             c_in;
    wire[31 : 0]    sum_o;
    wire            c_o;

    initial begin
        #10 a_in    = 32'h0000_0000;
            b_in    = 32'h0000_0000;
            c_in    = 1'b0;

        #10 a_in    = 32'h0000_FFFF;
            b_in    = 32'h0000_FFFF;
            c_in    = 1'b0;

        #10 a_in    = 32'hFFFF_0000;
            b_in    = 32'hFFFF_0000;
            c_in    = 1'b0;

        #10 a_in    = 32'hFFFF_0000;
            b_in    = 32'h0000_FFFF;
            c_in    = 1'b1;

        #10 a_in    = 32'hFFFF_FFFF;
            b_in    = 32'hFFFF_FFFF;
            c_in    = 1'b0;

        #10 a_in    = 32'hFFFF_FFFF;
            b_in    = 32'hFFFF_FFFF;
            c_in    = 1'b1;

        #10;

        $finish;
        
    end

    CLA32   ucla32( .a_in(a_in),
                    .b_in(b_in),
                    .c_in(c_in),
                    .sum_o(sum_o),
                    .c_o(c_o));

    

endmodule