`timescale 1ns/1ns
module ALU4_tb();
    parameter n = 3;
    reg [n : 0] a,
                b;
    reg [3 : 0] S;
    reg         M,
                cin;
    wire[n : 0] do;
    wire        co,
                V,
                Z;

    integer     i;

    ALU4 #(3) ualu4 (   .a(a),
                        .b(b),
                        .S(S),
                        .M(M),
                        .cin(cin),
                        .do(do),
                        .co(co),
                        .V(V),
                        .Z(Z));

    initial begin
        #10 a   = 4'b0000;
            b   = 4'b0000;
            S   = 4'b0000;
            M   = 1'b0;
            cin = 1'b1;

        #10 a   = 4'b1100;
            b   = 4'b1010;
            cin = 1'b1;
        for(i = 0; i < 16; i = i + 1) begin
            #10 S   = i;
        end

        #10 M   = 1'b1;
            cin = 1'b0;
            S   = 4'b1001;

        #10 S   = 4'b0110;

        #10 cin = 1'b1;

        #10 S   = 4'b1001;

        #10;
        $finish;
    end
    
endmodule