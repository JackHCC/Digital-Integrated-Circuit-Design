`timescale 1ns/1ns
module Seq (
    input   wire    A,
                    B,
                    clk,
                    clr,
    output  wire    Z
);

    parameter IDLE      = 3'b000;
    parameter S_01      = 3'b001;
    parameter S_0111    = 3'b010;
    parameter S_011     = 3'b011;
    parameter S_X0      = 3'b100;

    parameter act1      = 2'b00;
    parameter act2      = 2'b01;
    parameter act3      = 2'b10;
    parameter act4      = 2'b11;

    reg [2 : 0]     state,
                    state_cur;
    reg             out;

    wire[1 : 0]     bind;

    assign bind = {B, A};

    // Method1: Control signal and data are separate（Recommend）

    always @(posedge clk, posedge clr) begin
        if(clr)
            state_cur   <= IDLE;
        else
            state_cur   <= state;
            
    end

    always @(*) begin
        case(state_cur)
            IDLE:
                case(bind)
                    act1: begin
                        state   <= S_X0;
                        out     <= 0;
                    end 
                    act2: begin
                        state   <= S_01;
                        out     <= 0;
                    end     
                    act3: begin
                        state   <= S_X0;
                        out     <= 0;
                    end
                    act4: begin
                        state   <= IDLE;
                        out     <= 0;
                    end     
                    default: begin
                        state   <= 'bx;
                        out     <= 0;
                    end
                endcase              
            S_01:
                case(bind)
                    act1: begin
                        state   <= S_X0;
                        out     <= 0;
                    end 
                    act2: begin
                        state   <= S_01;
                        out     <= 0;
                    end     
                    act3: begin
                        state   <= S_X0;
                        out     <= 0;
                    end
                    act4: begin
                        state   <= S_0111;
                        out     <= 0;
                    end 
                    default: begin
                        state   <= 'bx;
                        out     <= 0;
                    end
                endcase  
            S_0111:
                case(bind)
                    act1: begin
                        state   <= S_X0;
                        out     <= 1;
                    end 
                    act2: begin
                        state   <= IDLE;
                        out     <= 1;
                    end     
                    act3: begin
                        state   <= S_X0;
                        out     <= 0;
                    end
                    act4: begin
                        state   <= IDLE;
                        out     <= 0;
                    end 
                    default: begin
                        state   <= 'bx;
                        out     <= 0;
                    end
                endcase  
            S_011:
                case(bind)
                    act1: begin
                        state   <= S_X0;
                        out     <= 0;
                    end 
                    act2: begin
                        state   <= S_01;
                        out     <= 0;
                    end     
                    act3: begin
                        state   <= IDLE;
                        out     <= 1;
                    end
                    act4: begin
                        state   <= IDLE;
                        out     <= 0;
                    end 
                    default: begin
                        state   <= 'bx;
                        out     <= 0;
                    end
                endcase  
            S_X0:
                case(bind)
                    act1: begin
                        state   <= S_X0;
                        out     <= 0;
                    end 
                    act2: begin
                        state   <= S_01;
                        out     <= 0;
                    end     
                    act3: begin
                        state   <= S_X0;
                        out     <= 0;
                    end
                    act4: begin
                        state   <= S_011;
                        out     <= 0;
                    end 
                    default: begin
                        state   <= 'bx;
                        out     <= 0;
                    end
                endcase
        endcase
        
    end

    // Method2: Control signal and data are together

    // always @(posedge clk, posedge clr) begin
    //     if(clr)
    //         state   <= IDLE;
    //     else
    //         case(state)
    //             IDLE:
    //                 case(bind)
    //                     act1: begin
    //                         state   <= S_X0;
    //                         out     <= 0;
    //                     end 
    //                     act2: begin
    //                         state   <= S_01;
    //                         out     <= 0;
    //                     end     
    //                     act3: begin
    //                         state   <= S_X0;
    //                         out     <= 0;
    //                     end
    //                     act4: begin
    //                         state   <= IDLE;
    //                         out     <= 0;
    //                     end     
    //                     default: begin
    //                         state   <= 'bx;
    //                         out     <= 0;
    //                     end
    //                 endcase              
    //             S_01:
    //                 case(bind)
    //                     act1: begin
    //                         state   <= S_X0;
    //                         out     <= 0;
    //                     end 
    //                     act2: begin
    //                         state   <= S_01;
    //                         out     <= 0;
    //                     end     
    //                     act3: begin
    //                         state   <= S_X0;
    //                         out     <= 0;
    //                     end
    //                     act4: begin
    //                         state   <= S_0111;
    //                         out     <= 0;
    //                     end 
    //                     default: begin
    //                         state   <= 'bx;
    //                         out     <= 0;
    //                     end
    //                 endcase  
    //             S_0111:
    //                 case(bind)
    //                     act1: begin
    //                         state   <= S_X0;
    //                         out     <= 1;
    //                     end 
    //                     act2: begin
    //                         state   <= IDLE;
    //                         out     <= 1;
    //                     end     
    //                     act3: begin
    //                         state   <= S_X0;
    //                         out     <= 0;
    //                     end
    //                     act4: begin
    //                         state   <= IDLE;
    //                         out     <= 0;
    //                     end 
    //                     default: begin
    //                         state   <= 'bx;
    //                         out     <= 0;
    //                     end
    //                 endcase  
    //             S_011:
    //                 case(bind)
    //                     act1: begin
    //                         state   <= S_X0;
    //                         out     <= 0;
    //                     end 
    //                     act2: begin
    //                         state   <= S_01;
    //                         out     <= 0;
    //                     end     
    //                     act3: begin
    //                         state   <= IDLE;
    //                         out     <= 1;
    //                     end
    //                     act4: begin
    //                         state   <= IDLE;
    //                         out     <= 0;
    //                     end 
    //                     default: begin
    //                         state   <= 'bx;
    //                         out     <= 0;
    //                     end
    //                 endcase  
    //             S_X0:
    //                 case(bind)
    //                     act1: begin
    //                         state   <= S_X0;
    //                         out     <= 0;
    //                     end 
    //                     act2: begin
    //                         state   <= S_01;
    //                         out     <= 0;
    //                     end     
    //                     act3: begin
    //                         state   <= S_X0;
    //                         out     <= 0;
    //                     end
    //                     act4: begin
    //                         state   <= S_011;
    //                         out     <= 0;
    //                     end 
    //                     default: begin
    //                         state   <= 'bx;
    //                         out     <= 0;
    //                     end
    //                 endcase
    //         endcase
            
    // end

    assign  Z   = out;

    
endmodule
