module COMPARATOR (
    input   wire    [3:0]   alarm_hours,
                    [5:0]   alarm_mins,
    input   wire            alarm_AM_PM,
                    [3:0]   time_hours,
                    [5:0]   time_mins,
    input   wire            time_AM_PM,
    output  wire            RINGER1  
);

    reg     hours, mins, AM_PM;

    always @(*) begin
        if(alarm_hours == time_hours) 
            hours = 1;
        else
            hours = 0;
        if(alarm_mins == time_mins)
            mins = 1;
        else
            mins = 0;
        if(alarm_AM_PM == time_AM_PM)
            AM_PM = 1;
        else
            AM_PM = 0;
    end
    
    assign RINGER1 = hours & mins & AM_PM;
    
endmodule
