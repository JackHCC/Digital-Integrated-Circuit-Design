`timescale 1ns/1ns
module CLA4 (
    input   wire    ci,
            wire    [3 : 0] a,
                            b,
    output  wire    [3 : 0] s,
            wire            co
);

    wire [3 : 0]    g, 
                    p,
                    G,
                    P,
                    c;

    // Using function to practice
    function    [3 : 0] and4;
        input   [3 : 0] a,
                        b;
        assign  and4   = a & b;     
    endfunction

    function    [3 : 0] xor4;
        input   [3 : 0] a,
                        b;
        assign  xor4   = a ^ b;
    endfunction

    // Test function, Must use keyword assign
    assign g = and4(a, b);
    assign p = xor4(a, b);

    // assign  g   = a & b;
    // assign  p   = a ^ b;

    assign  G[0]= g[0];
    assign  P[0]= p[0];
    assign  G[1]= g[1] | (p[1] & g[0]);
    assign  P[1]= p[1] & p[0];
    assign  G[2]= g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]);
    assign  P[2]= p[2] & p[1] & p[0];
    assign  G[3]= g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);
    assign  P[3]= p[3] & p[2] & p[1] & p[0];

    assign  c   = G | (P & {4{ci}});
    assign  s   = p ^ {c[2 : 0], ci};
    assign  co  = c[3];
    
endmodule
