`timescale 1ns/1ns
module ALU32_tb ();
    parameter n = 31;
    reg [n : 1] a,
                b;
    reg [3 : 0] S;
    reg         M,
                cin;
    wire[n : 0] do;
    wire        N,
                C,
                V,
                Z;

    initial begin
        #10 a   = 32'h0000_0000;
            b   = 32'h0000_0000;
            S   = 4'h0;
            M   = 1'b0;
            cin = 1'b1;

        #10 a   = 32'hFFFF_FFFF;
            b   = 32'h0000_0001;
            S   = 4'b1001;
            M   = 1'b1;
            cin = 1'b0;

        #10 a   = 32'hFFFF_FFFF;
            b   = 32'hFFFF_FFFF;

        #10 a   = 32'h7FFF_FFFF;
            b   = 32'hFFFF_FFFF;

        #10 a   = 32'h3FFF_FFFF;
            b   = 32'h0FFF_FFFF;

        #10;

        $finish;
    end

    // there are a bug about highest bit
    ALU32 ualu_32( .a(a),
                    .b(b),
                    .S(S),
                    .M(M),
                    .cin(cin),
                    .do(do),
                    .C(C),
                    .N(N),
                    .Z(Z),
                    .V(V));

endmodule