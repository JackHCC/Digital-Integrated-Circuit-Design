`timescale 1ns/1ns
module FSM2 (
    input   wire    reset_n,
                    X,
                    clk,
    output  wire    Z1,
                    Z2
);

    // Method2: Count
    reg [1 : 0] cnt;

    always @(posedge clk, negedge reset_n) begin
        if(!reset_n) begin
            cnt <= 0;
        end
        else 
            if(X) begin
                if(cnt != 2'b11)
                    cnt <= cnt + 1'b1;
            end
    end

    assign Z1 = ^ cnt;
    assign Z2 = & cnt;

endmodule


