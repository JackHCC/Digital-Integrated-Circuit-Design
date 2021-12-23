`timescale 1ns/1ns
module ALU4 #(
    parameter n = 3
    )(
    input   wire    [n : 0] a,
                            b,
            wire    [3 : 0] S,
            wire            M,
                            cin,
    output  wire    [n : 0] do,
            wire            co,
                            V,
                            Z
    );

    integer             i;
    reg    [n : 0]      g, p;
    wire   [n : 0]      G, P;
    wire   [n + 1 : 0]  c;

    always @(*) begin
        for(i = 0; i < 4; i = i + 1) begin
            p[i] = !(( S[3] &  a[i] &  b[i] ) ||
                     ( S[2] &  a[i] & !b[i] ) ||
                     ( S[1] & !a[i] &  b[i] ) ||
                     ( S[0] & !a[i] & !b[i] ));
            g[i] =  ( S[2] & a[i] & !b[i] ) ||
                    ( S[3] & a[i] &  b[i] ) ||
                    !M ;
        end
    end

    assign G[0] = g[0];
    assign G[1] = g[1] | ( p[1] & G[0] ) ;
    assign G[2] = g[2] | ( p[2] & G[1] ) ;
    assign G[3] = g[3] | ( p[3] & G[2] ) ; 
    assign P[0] = p[0] ;
    assign P[1] = p[1] & P[0] ;
    assign P[2] = p[2] & P[1] ;
    assign P[3] = p[3] & P[2] ; 
    assign c[0] = cin;
    assign c[n + 1 : 1] = G | ( P & {4{c[0]}} );
    
    assign do   = p ^ (c[n : 0]);
    assign co   = c[n + 1];
    assign V    = c[n + 1] ^ c[n];
    assign Z    = !(| do);

endmodule