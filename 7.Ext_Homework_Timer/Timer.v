module Timer (
    input   wire            reset_n,
                            clk,
                            set_time,
                            alarm,
                            Toggle_switch,
                            hours_set,
                            mins_set,
    output  wire [13 : 0]   hours_disp,
            wire [13 : 0]   mins_disp,
    
    output  wire            AM_PM_disp,
    output  wire            SPEAKER_OUT

);

    wire        set_alarm_hours;
    wire        set_alarm_mins;
    wire [3:0]  hours_alarm_out;
    wire [5:0]  mins_alarm_out;
    wire 	    AM_PM_alarm;

    wire        set_time_hours;
    wire        set_time_mins;
    wire        secs;
    wire [3:0]  hours_time_out;
    wire [5:0]  mins_time_out;
    wire 	    AM_PM_time;

    wire        RINGER1;

    wire [3:0]  hours_chose;
    wire [5:0]  mins_chose;

    ALARM_STATE_MACHINE uo( .reset_n(reset_n), 
                            .clk(clk), .alarm(alarm), 
                            .hours_set(hours_set), 
                            .mins_set(mins_set), 
                            .hours(set_alarm_hours), 
                            .mins(set_alarm_mins));

    ALARM_COUNTER u1(   .reset_n(reset_n), 
                        .clk(clk), 
                        .HOURS(set_alarm_hours), 
                        .MINS(set_alarm_mins),
                        .HOURS_OUT(hours_alarm_out), 
                        .MINUTES_OUT(mins_alarm_out), 
                        .AM_PM_OUT(AM_PM_alarm));

    TIME_STATE_MACHINE u2(  .reset_n(reset_n), 
                            .clk(clk), 
                            .set_time(set_time), 
                            .hours_set(hours_set), 
                            .mins_set(mins_set), 
                            .hours(set_time_hours), 
                            .mins(set_time_mins), 
                            .secs(secs));

    TIME_COUNTER u3(    .reset_n(reset_n), 
                        .clk(clk), 
                        .HOURS(set_time_hours), 
                        .MINS(set_time_mins), 
                        .SECS(secs),
                        .HOURS_OUT(hours_time_out), 
                        .MINUTES_OUT(mins_time_out), 
                        .AM_PM_OUT(AM_PM_time));

    COMPARATOR u4(  .alarm_hours(hours_alarm_out), 
                    .alarm_mins(mins_alarm_out), 
                    .alarm_AM_PM(AM_PM_alarm), 
                    .time_hours(hours_time_out), 
                    .time_mins(mins_time_out), 
                    .time_AM_PM(AM_PM_time), 
                    .RINGER1(RINGER1));

    MUX u5( .alarm(alarm), 
            .HOURS_OUT_alarm(hours_alarm_out), 
            .HOURS_OUT_time(hours_time_out), 
            .MINUTES_OUT_alarm(mins_alarm_out), 
            .MINUTES_OUT_time(mins_time_out), 
            .AM_PM_OUT_alarm(AM_PM_alarm), 
            .AM_PM_OUT_time(AM_PM_time), 
            .HOURS_OUT(hours_chose), 
            .MINUTES_OUT(mins_chose), 
            .AM_PM_OUT(AM_PM_disp));

    ALARM_SM_2 u6(  .reset_n(reset_n), 
                    .clk(clk), 
                    .Toggle_switch(Toggle_switch), 
                    .MATCH(RINGER1), 
                    .SPEAKER_OUT(SPEAKER_OUT));

    CONVERTOR_CKT u7(   .hours_cur(hours_chose), 
                        .mins_cur(mins_chose), 
                        .hours_disp(hours_disp), 
                        .mins_disp(mins_disp));

    
endmodule
