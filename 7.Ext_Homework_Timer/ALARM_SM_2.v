module ALARM_SM_2 (
    input   wire    reset_n,
                    clk,
                    Toggle_switch,
                    MATCH,          // flag of alarm time equal to current time
    output  reg     SPEAKER_OUT             
);
    always @(posedge clk, negedge reset_n) begin
        if(!reset_n)begin   
            SPEAKER_OUT = 0;
        end

        else begin
            if(Toggle_switch & MATCH)
                SPEAKER_OUT = 1;
            else
                SPEAKER_OUT = 0;
        end
    end
    
endmodule
