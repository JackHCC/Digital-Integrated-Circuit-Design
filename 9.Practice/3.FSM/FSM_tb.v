`timescale 1ns/1ns
module FSM_tb ();
    reg     reset_n,
            X,
            clk;
    wire    Z1,
            Z2;

    always #5   clk = ~clk;

    initial begin
        clk = 0;
        reset_n = 0;
        X = 0;

        @(posedge clk);
        reset_n = 1;

        @(posedge clk);
        X = 1;

        #60;
        $finish;
    end

    // Method 1
    // FSM ufsm(   .reset_n(reset_n),
    //             .X(X),
    //             .clk(clk),
    //             .Z1(Z1),
    //             .Z2(Z2));

    // Method 2
    // FSM2 ufsm(  .reset_n(reset_n),
    //             .X(X),
    //             .clk(clk),
    //             .Z1(Z1),
    //             .Z2(Z2));

    // Method 3
    FSM3 ufsm(  .reset_n(reset_n),
                .X(X),
                .clk(clk),
                .Z1(Z1),
                .Z2(Z2));
    
endmodule