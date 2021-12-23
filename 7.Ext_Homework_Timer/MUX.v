module MUX (
    input   wire            alarm,
            wire    [3:0]   HOURS_OUT_alarm,
                    [3:0]   HOURS_OUT_time,
                    [5:0]   MINUTES_OUT_alarm,
                    [5:0]   MINUTES_OUT_time,
                            AM_PM_OUT_alarm,
                            AM_PM_OUT_time,
    output  reg     [3:0]   HOURS_OUT,
                    [5:0]   MINUTES_OUT,
                            AM_PM_OUT
);

    always @(*) begin
        if (alarm) begin
            HOURS_OUT   = HOURS_OUT_alarm;
            MINUTES_OUT = MINUTES_OUT_alarm;
            AM_PM_OUT   = AM_PM_OUT_alarm;
        end
        else begin
            HOURS_OUT   = HOURS_OUT_time;
            MINUTES_OUT = MINUTES_OUT_time;
            AM_PM_OUT   = AM_PM_OUT_time;
        end
    end  
endmodule

