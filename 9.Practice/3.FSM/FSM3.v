`timescale 1ns/1ns
module FSM3 (
    input   wire    reset_n,
                    X,
                    clk,
    output  wire    Z1,
                    Z2
);

    // Method2: Buffer
    reg [2 : 0] buffer;

    always @(posedge clk, negedge reset_n)
        if(!reset_n) begin
            buffer <= 0;
        end
        else begin
            buffer[0]   <= X;
            buffer[1]   <= buffer[0];
            buffer[2]   <= buffer[1] | buffer[2];
        end
    
    assign Z1 = buffer[0] & !buffer[2];
    assign Z2 = buffer[2];

endmodule



