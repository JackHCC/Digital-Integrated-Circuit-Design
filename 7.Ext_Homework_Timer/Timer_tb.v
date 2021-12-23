`timescale 100ms/100ms
module Timer_tb();
    reg             reset_n,
                    clk,
                    set_time,
                    alarm,
                    Toggle_switch,
                    hours_set,
                    mins_set;
    wire [13 : 0]   hours_disp;
    wire [13 : 0]   mins_disp;
        
    wire            AM_PM_disp;
    wire            Speaker_out;
    Timer u0(reset_n, clk, set_time, alarm, Toggle_switch, hours_set, mins_set, hours_disp, mins_disp, AM_PM_disp, Speaker_out);
    always #5 clk = ~clk;
    initial begin
        reset_n     = 0;
        clk         = 0;
        set_time    = 0;
        alarm       = 0;
        hours_set   = 0;
        mins_set    = 0;
        Toggle_switch = 0;
        @(posedge clk);
        reset_n     = 1;
        set_time    = 1;
        @(posedge clk);
        repeat(10) begin
            @(posedge clk);
            hours_set = 1;
            @(posedge clk);
            hours_set = 0;
            end
        @(posedge clk);
        repeat(20) begin
            @(posedge clk);
            mins_set = 1;
            @(posedge clk);
            mins_set = 0;
            end
        set_time = 0;
        alarm = 1;
        repeat(10) begin
            @(posedge clk);
            hours_set = 1;
            @(posedge clk);
            hours_set = 0;
            end
        @(posedge clk);
        repeat(23) begin
            @(posedge clk);
            mins_set = 1;
            @(posedge clk);
            mins_set = 0;
            end
        @(posedge clk);
        Toggle_switch = 1;
        alarm = 0;
        
        #3000;
        $finish;
    end
endmodule
		

