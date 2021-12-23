module ALARM_COUNTER(
    input   wire        reset_n,
                        clk,
                        HOURS,
                        MINS,
    output  reg [3:0]   HOURS_OUT,
            reg [5:0]   MINUTES_OUT,
            reg         AM_PM_OUT
);
    reg         flag;
    reg [3:0]   hour_cur;
    reg [5:0]   min_cur;

    always @(posedge clk, negedge reset_n) begin

        if(!reset_n) begin
            hour_cur    = 0;
            min_cur     = 0;
            AM_PM_OUT   = 0;
            HOURS_OUT   = 0;
            MINUTES_OUT = 0;
            flag        = 0;    
        end 

        else begin
            hour_cur = hour_cur + HOURS;
            min_cur  = min_cur + MINS;

            if(min_cur == 60) begin
                min_cur = 0;
                hour_cur= hour_cur + 1;
            end

            if(hour_cur == 24)
                hour_cur= 0;

            flag = hour_cur / 12;

            if(flag == 0)
                AM_PM_OUT = 0;
            else
                AM_PM_OUT = 1;
                HOURS_OUT = hour_cur % 12;
                MINUTES_OUT = min_cur % 60;
        end 
    end
    
endmodule
