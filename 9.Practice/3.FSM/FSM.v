`timescale 1ns/1ns
module FSM (
    input   wire    reset_n,
                    X,
                    clk,
    output  wire    Z1,
                    Z2
);

    // Method1: State Machine
    reg [1 : 0] state;

    parameter IDLE      = 2'b00;
    parameter State1    = 2'b01;
    parameter State2    = 2'b10;
    parameter State3    = 2'b11;

    always @(posedge clk, negedge reset_n) begin
        if(!reset_n) begin
            state <= 0;
        end
        else begin
            case (state)
                IDLE:
                    if(X)
                        state = State1;
                State1:
                    if(X)
                        state = State2;
                State2:
                    if(X)
                        state = State3;
                default: 
                    state = State3;
            endcase 
        end
    end

    // Ouput can be assign by state combination ,so Output can be wire type
    assign Z1 = (state == State1) || (state == State2);
    assign Z2 = (state == State3);

endmodule

