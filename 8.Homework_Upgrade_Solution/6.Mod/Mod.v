`timescale 1ns/1ns
module Mod (
    input   wire [7 : 0]    data_in,
            wire            rdy,
                            clk,
                            reset_n,
    output  reg  [4 : 0]    dmod,
            reg             mod_en,
                            rd
);

    
    reg [3 : 0] state;
    reg [7 : 0] buffer;
    reg         flag;

    parameter IDLE      = 4'b0000;
    parameter S_3_5     = 4'b0001;
    parameter S_6_2     = 4'b0010;
    parameter S_1_5_2   = 4'b0011;
    parameter S_4_4     = 4'b0100;
    parameter S_7_1     = 4'b0101;
    parameter S_2_5_1   = 4'b0110;
    parameter S_5_3     = 4'b0111;
    parameter S_5       = 4'b1000;

    always @(posedge clk, negedge reset_n) begin
        if(!reset_n)   begin
                state   = IDLE;
                buffer  = 0;
                flag    = 0;
        end
        else
                case(state)
                        IDLE: begin
                                buffer  = 0;
                                flag    = 0;
                                state   = S_3_5;
                                
                        end
                        S_3_5: begin
                                state   = S_6_2;
                                dmod    = data_in[4 : 0];
                                buffer  = data_in[7 : 5];
                                flag    = 0;  
                        end
                        S_6_2: begin
                                state   = S_1_5_2;
                                dmod    = {data_in[1 : 0], buffer[2 : 0]};
                                buffer  = data_in[7 : 2];
                                flag    = 1;
                        end       
                        S_1_5_2: begin
                                state   = S_4_4;
                                dmod    = buffer[4 : 0];
                                buffer  = buffer >> 5;
                                flag    = 0;
                        end       
                        S_4_4: begin
                                state   = S_7_1;
                                dmod    = {data_in[3 : 0], buffer[0]};
                                buffer  = data_in[7 : 4];
                                flag    = 0;
                        end       
                        S_7_1: begin
                                state   = S_2_5_1;
                                dmod    = {data_in[0], buffer[3 : 0]};
                                buffer  = data_in[7 : 1];
                                flag    = 1;
                        end       
                        S_2_5_1: begin
                                state   = S_5_3;
                                dmod    = buffer[4 : 0];
                                buffer  = buffer >> 5;
                                flag    = 0;
                        end       
                        S_5_3: begin
                                state   = S_5;
                                dmod    = {data_in[2 : 0], buffer[1 : 0]};
                                buffer  = data_in[7 : 3];
                                flag    = 1;
                        end
                        S_5: begin
                                state   = IDLE;
                                dmod    = buffer[4 : 0];
                                buffer  = buffer >> 5;
                                flag    = 0;
                        end
                        default: begin
                                state   = 'bx;
                        end
                endcase
            
    end

    always @(*) begin
        rd   = !rdy && !flag; 
        if(state <= S_5 && state >IDLE) 
                if(!rdy)
                        mod_en  = 1;
                else if(rdy && flag)
                        mod_en  = 1;
                else
                        mod_en  = 0;
        else
                mod_en  = 0;
    end
endmodule