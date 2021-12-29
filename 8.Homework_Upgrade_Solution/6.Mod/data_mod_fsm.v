`timescale 1ns/1ps

module data_mod_fsm(
    input wire          clk,
                        reset_n,
                        rdy,
    input wire [7:0]    data_in,
    output reg [4:0]    dmod,
    output reg          rd,
                        mod_en
);

    parameter st_0 = 3'd0, st_3 = 3'd1, st_6 = 3'd2,
                st_1 = 3'd3, st_4 = 3'd4, st_7 = 3'd5,
                st_2 = 3'd6, st_5 = 3'd7;
    
    reg [2:0]   current_state,
                next_state;

    reg [7:0]   data_buf;

    always @(posedge clk, negedge reset_n) begin
        if(!reset_n)
            current_state <= st_0;
        else
            current_state <= next_state;
    end

    always @(*) begin
        case(current_state)
            st_0:   if(!rdy) next_state = st_3;
                    else next_state = st_0;
            st_3:   if(!rdy) next_state = st_6;
                    else next_state = st_3;
            st_6:   if(!rdy) next_state = st_1;
                    else next_state = st_1;
            st_1:   if(!rdy) next_state = st_4;
                    else next_state = st_1;
            st_4:   if(!rdy) next_state = st_7;
                    else next_state = st_4;
            st_7:   if(!rdy) next_state = st_2;
                    else next_state = st_2;
            st_2:   if(!rdy) next_state = st_5;
                    else next_state = st_2;
            st_5:   if(!rdy) next_state = st_0;
                    else next_state = st_0;
            default: next_state = st_0;
        endcase
    end

    always @(posedge clk, negedge reset_n) begin
        if(!reset_n) begin
            mod_en <= 1'b0;
            rd <= 1'b0;
        end
        else begin
            case(current_state)
                st_0:   if(!rdy) begin
                            dmod <= data_in[4:0];
                            mod_en <= 1'b1;
                            data_buf <= data_in[7:5];
                            rd <= 1'b1;
                        end
                        else begin
                            mod_en <= 1'b0;
                            rd <= 1'b0;
                        end
                st_3:   if(!rdy) begin
                            dmod <= {data_in[1:0], data_buf[2:0]};
                            mod_en <= 1'b1;
                            data_buf <= data_in[7:2];
                            rd <= 1'b0;
                        end
                        else begin
                            mod_en <= 1'b0;
                            rd <= 1'b0;
                        end
                st_6:   if(!rdy) begin
                            dmod <= data_buf[4:0];
                            mod_en <= 1'b1;
                            data_buf <= data_buf[5];
                            rd <= 1'b1;
                        end
                        else begin
                            dmod <= data_buf[4:0];
                            mod_en <= 1'b1;
                            data_buf <= data_buf[5];
                            rd <= 1'b0;
                        end
                st_1:   if(!rdy) begin
                            dmod <= {data_in[3:0], data_buf[0]};
                            mod_en <= 1'b1;
                            data_buf <= data_in[7:4];
                            rd <= 1'b1;
                        end
                        else begin
                            mod_en <= 1'b0;
                            rd <= 1'b0;
                        end
                st_4:   if(!rdy) begin
                            dmod <= {data_in[0], data_buf[3:0]};
                            mod_en <= 1'b1;
                            data_buf <= data_in[7:1];
                            rd <= 1'b0;
                        end
                        else begin
                            mod_en <= 1'b0;
                            rd <= 1'b0;
                        end
                st_7:   if(!rdy) begin
                            dmod <= data_buf[4:0];
                            mod_en <= 1'b1;
                            data_buf <= data_buf[6:5];
                            rd <= 1'b1;
                        end
                        else begin
                            dmod <= data_buf[4:0];
                            mod_en <= 1'b1;
                            data_buf <= data_buf[6:5];
                            rd <= 1'b0;
                        end
                st_2:   if(!rdy) begin
                            dmod <= {data_in[2:0], data_buf[1:0]};
                            mod_en <= 1'b1;
                            data_buf <= data_in[7:3];
                            rd <= 1'b0;
                        end
                        else begin
                            mod_en <= 1'b0;
                            rd <= 1'b0;
                        end
                st_5:   if(!rdy) begin
                            dmod <= data_buf[4:0];
                            mod_en <= 1'b1;
                            rd <= 1'b1;
                        end
                        else begin
                            dmod <= data_buf[4:0];
                            mod_en <= 1'b1;
                            rd <= 1'b0;
                        end
            endcase

        end

    end

    specify
        // (data_in => dmod) = (1, 1, 1);
        (rdy => rd) = (4, 4);
    endspecify


endmodule