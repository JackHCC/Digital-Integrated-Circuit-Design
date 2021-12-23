`timescale 1ns/1ns
module ALU32 #(
    parameter n = 31
    )(
    input   wire    [n : 0] a,
                            b,
            wire    [3 : 0] S,
            wire            M,
                            cin,
    output  wire    [n : 0] do,
            wire            N,
                            V,
                            Z,
                            C
    );

    wire [8 : 0]    co;
    wire [7 : 0]    Zo, Vo;

    assign co[0]    = cin;

    generate
        genvar i;
        for(i = 0; i < 8; i = i + 1) begin: u
            ALU4 ua(    .a(a[4 * i + 3 : 4 * i]),
                        .b(b[4 * i + 3 : 4 * i]),
                        .S(S),
                        .M(M),
                        .cin(co[i]),
                        .do(do[4 * i + 3 : 4 * i]),
                        .co(co[i + 1]),
                        .V(Vo[i]),
                        .Z(Zo[i]));
        end
    endgenerate 

    assign N    = do[n];
    assign C    = co[8];
    assign Z    = & Zo;
    assign V    = Vo[7];
endmodule
