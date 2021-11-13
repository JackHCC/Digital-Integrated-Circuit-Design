`timescale  10ns/1ns

module seq_detection (
    input   wire    A,
                    B,
                    clk,
                    clr,
    output  wire    Z
);

    reg     [3 : 0] state;
    wire    [1 : 0] bind;
    reg             out;

    assign  bind    = {A, B};
    
    parameter   zero  = 3'b000,
                one   = 3'b001,
                two   = 3'b010,
                three = 3'b011,
                four  = 3'b100; 

    always @(posedge clk, posedge clr)
        if(clr)
	    begin
            state <= 0;
		    out <= 0;
	    end
        else
            case(state)
                zero : 
                    if(bind == 2'b01)
                    begin
                        state <= one;
                        out   <= 0;
                    end
                    else if(bind == 2'bx0)
                    begin
                        state <= two;
                        out   <= 0;
                    end
                    else
                        out  <= 0;
                one :
                    if(bind == 2'bx0)
                    begin
                        state <= one;
                        out   <= 0;
                    end
                    else if(bind == 2'b11)
                    begin
                        state <= three;
                        out   <= 0;
                    end
                    else
                        out  <= 0;
                two :
                    if(bind == 2'b01)
                    begin
                        state <= one;
                        out   <= 0;
                    end
                    else if(bind == 2'b11)
                    begin
                        state <= four;
                        out   <= 0;
                    end
                    else
                        out  <= 0;

                three:
                    if(bind == 2'b01) 
                    begin
                        state <= zero;
                        out   <= 1;
                    end
                    else if(bind == 2'b11)
                    begin
                        state <= zero;
                        out   <= 0;
                    end
                    else if(bind == 2'b00)
                    begin
                        state <= two;
                        out   <= 1;
                    end
                    else 
                    begin
                        state <=two;
                        out   <= 0;
                    end

                four:
                    if(bind == 2'b01)
                    begin
                        state <= one;
                        out   <= 0;
                    end
                    else if(bind == 2'b00)
                    begin
                        state <= two;
                        out   <= 0;
                    end
                    else if(bind == 2'b11)
                    begin
                        state <= zero;
                        out   <= 0;
                    end
                    else
                    begin
                        state <= zero;
                        out   <= 1;
                    end
                default:
                begin
                    state <= 'bx;
                    out   <= 0;
                end
            endcase
        
    assign  Z   = out;

endmodule




