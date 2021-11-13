`timescale  10ns/1ns

module seq_detection_tb ();
    reg     clk,
            clr,
            A,
            B;
    wire    Z;


    always #5   clk = !clk;
    parameter   n   = 19;
    reg    [n : 0] seq_in;

    initial begin
        clk     = 0;
        clr     = 1;
        seq_in  = 20'b0111_0011_1011_1101_1100;
        A       = 0;
        B       = 0;
        @(posedge clk);
            clr = 1'b0;
            repeat(12) begin
                @(negedge clk);
                    A       = seq_in[n];
                    B       = seq_in[n-1];
                    seq_in  = seq_in << 2;
            end
	$finish;
    end

seq_detection   u(
        .clk(clk),
        .clr(clr),
        .A(A),
        .B(B),
        .Z(Z)
    );
    
endmodule
