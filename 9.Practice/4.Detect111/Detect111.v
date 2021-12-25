`timescale 1ns/1ns
module Detect111 (
    input   wire    X,
                    clk,
                    rst,
    output  wire    out
);
    
    reg [1 : 0] state;

    parameter IDLE      = 2'b00;
    parameter State1    = 2'b01;
    parameter State2    = 2'b10;
    parameter State3    = 2'b11;


    always @(posedge clk, posedge rst) begin
        if(rst)
            state <= 0;
        else
            case (state)
                IDLE:
                    if(X)
                        state = State1;
                    else
                        state = IDLE;
                State1:
                    if(X)
                        state = State2;
                    else
                        state = IDLE;
                State2:
                    if(X)
                        state = State3;
                    else
                        state = IDLE;
                State3:
                    state = State3;
            endcase
        
    end

    assign out = (state == State3);

endmodule