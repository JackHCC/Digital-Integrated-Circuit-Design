`timescale 1ns/1ns
module RTL_tb ();
    reg         sr,
                sl,
                ld,
                D_sr,
                D_sl,
                clk;
    reg [3 : 0] D;
    wire[3 : 0] Q;

    always #5   clk = ~clk;

    initial begin
        clk = 0;
        #10 D   = 4'b1010;
            sl  = 0;
            ld  = 1;
            sr  = 1;
            D_sr= 0;
            D_sl= 0;

        #10 D   = 4'b1010;
            ld  = 1;
            sl  = 1;
            sr  = 0;
            D_sr= 0;
            D_sl= 0;

        #10 D   = 4'b0101;
            ld  = 1;
            sl  = 1;
            sr  = 0;
            D_sr= 0;
            D_sl= 0;

        #10;
        $finish;
    end

    // The simulator has some wrong to solve
    RTL urtl(   .sr(sr),
                .sl(sl),
                .ld(ld),
                .D_sr(D_sr),
                .D_sl(D_sl),
                .clk(clk),
                .D(D),
                .Q(Q));
    
endmodule
