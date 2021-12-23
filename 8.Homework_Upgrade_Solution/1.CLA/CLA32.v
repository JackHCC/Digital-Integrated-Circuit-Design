`timescale 1ns/1ns
module CLA32 (
    input   wire    [31 : 0]    a_in,
                                b_in,
            wire                c_in,
    output  wire    [31 : 0]    sum_o,
            wire                c_o    
);

    wire [8 : 0]   c;

    assign c[0] = c_in;
    assign c_o  = c[8];
    generate
        genvar i;
        for(i = 0; i < 32; i = i + 4) begin: u
            CLA4 cla4(  .a(a_in[i+3 : i]),
                        .b(b_in[i+3 : i]),
                        .ci(c[i/4]),
                        .s(sum_o[i+3 : i]),
                        .co(c[i/4 + 1]));
        end
    endgenerate   
endmodule
