`timescale 1ns/1ns
module Tran (
    input  wire         reset_n,
                        clk,
                        start,
                        byte,
                [7 : 0] data_in,
    output wire [7 : 0] data_o,
           wire         data_en
);

    reg     state;
    
    parameter S_0 = 0;
    parameter S_4 = 1;

    reg [7 : 0]     do;
    reg             en;

    reg [3 : 0]     buffer;

    always @(posedge clk, negedge reset_n) begin
        if(!reset_n) begin
            state   = 0;
            buffer  = 0;
            en = 0;
            do  = 0;
        end
        else
            if(start)
                case(state)
                    S_0:
                        case(byte)
                            1: begin
                                state   = state;
                                do      = data_in;
                                en      = 1;
                            end
                            0: begin
                                state   = S_4;
                                buffer     = data_in[3 : 0];
                                en      = 0;
                            end
                            default: begin
                                state   = 'bx;
                                en      = 0;
                            end
                        endcase
                    S_4:
                        case(byte)
                            1: begin
                                state   = state;
                                do      = {data_in[3 : 0], buffer};
                                buffer     = data_in[7 : 4];
                                en      = 1;
                            end
                            0: begin
                                state   = S_0;
                                do      = {data_in[3 : 0], buffer};
                                en      = 1;
                            end
                            default: begin
                                state   = 'bx;
                                en      = 0;
                            end
                        endcase

                endcase
            else begin
                state  = S_0;
                buffer = 0;
                en     = 0;
            end      
    end

    assign  data_o  = do;
    assign  data_en = en;
    
endmodule