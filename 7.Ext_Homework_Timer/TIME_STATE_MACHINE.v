module TIME_STATE_MACHINE(
    input   wire    reset_n,
                    clk,
                    set_time,
                    hours_set,
                    mins_set,
    output  reg     hours,
                    mins,
                    secs
    
);

    parameter   IDLE    = 2'b00,    // init state and no press action
                MINS_S    = 2'b01,    // press mins_set
                HOURS_S   = 2'b10,    // press hours_set
                BOTH    = 2'b11;    // press both
    
    reg [1 : 0] state;

    always @(posedge clk, negedge reset_n) begin
        if(!reset_n) begin
            hours = 0;
            mins = 0;
            state = 0;
            secs = 0;  
        end  
        else if(set_time) begin
            secs = 0;
            case(state)
                IDLE: begin
                    case({hours_set, mins_set})
                        IDLE: begin
                            state = IDLE;
                            hours = 0;
                            mins = 0;
                        end

                        MINS_S: begin
                            state = MINS_S;
                            hours = 0;
                            mins = 0;
                        end

                        HOURS_S: begin
                            state = HOURS_S;
                            hours = 0;
                            mins = 0;
                        end

                        BOTH: begin
                            state = IDLE;
                            hours = 0;
                            mins = 0;
                        end
                
                    endcase
                end

                MINS_S: begin  
                    case({hours_set, mins_set})
                        IDLE: begin
                            state = IDLE;
                            hours = 0;
                            mins = 1;
                        end

                        MINS_S: begin
                            state = MINS_S;
                            hours = 0;
                            mins = 0;
                        end

                        HOURS_S: begin
                            state = HOURS_S;
                            hours = 0;
                            mins = 1;
                        end

                        BOTH: begin
                            state = IDLE;
                            hours = 0;
                            mins = 0;
                        end
                    endcase
                end
                    
                HOURS_S: begin
                    case({hours_set, mins_set})
                        IDLE: begin
                            state = IDLE;
                            hours = 1;
                            mins = 0;
                        end

                        MINS_S: begin
                            state = MINS_S;
                            hours = 1;
                            mins = 0;
                        end

                        HOURS_S: begin
                            state = HOURS_S;
                            hours = 0;
                            mins = 0;
                        end

                        BOTH: begin
                            state = IDLE;
                            hours = 0;
                            mins = 0;
                        end
                    endcase
                end
            endcase
        end  

        else begin
            secs = 1;
            hours = 0;
            mins = 0;
            state = 0;
        end  
    end  
endmodule