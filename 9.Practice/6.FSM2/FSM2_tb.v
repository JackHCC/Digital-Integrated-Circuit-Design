`timescale 1ns/1ns
module FSM2_tb ();
    reg     clk,
            clr;
    wire    Q0,
            Q1,
            Q2;
    
    always #5 clk   = ~clk;

    initial begin
        clk = 0;
        clr = 1;

        @(posedge clk);
        clr = 0;

        repeat(10)
            @(posedge clk);


        $finish;
    end

    FSM2 u( .clk(clk),
            .clr(clr),
            .Q0(Q0),
            .Q1(Q1),
            .Q2(Q2));

    // initial begin
    //     $shm_open("wave.shm");
    //     $shm_probe();
    // end
endmodule