`timescale 1ns/1ns
module Mod_tb ();
    reg [7 : 0] data_in;
    reg         rdy,
                clk,
                reset_n;
    wire[4 : 0] dmod;
    wire        mod_en,
                rd;

    integer     i;
    integer     MCD;
    reg [7 : 0] mem[63 : 0];
    always #5 clk = ~clk;

    // Test Task
    task test;
        input [7 : 0]   data;
        integer i;
        begin
            data_in     = data;
            
            for(i = 0; i < 10; i = i + 1) begin
                @(posedge clk);
                data_in = data_in + 1;
            end  
        end
    endtask

    // Test dump
    initial begin
        $dumpfile("waves.dump");
        // $dumpvars(0, umod);
        $dumpvars;

        // $shm_open("waves.shm");
        // $shm_probe();
    end

    // Test Output File
    initial begin
        MCD = $fopen("wave.dat");
        $fmonitor(MCD, $time, "dmod = %b, mod_en = %b, rd = %b", dmod, mod_en, rd);

    end

    // Test Readmem(Input File)
    initial begin
        $readmemb("wave.txt", mem);
        $display("mem = %b", mem[0]);
        $display("mem = %b", mem[1]);
        $display("mem = %b", mem[2]);
        $display("mem = %b", mem[15]);
        $display("mem = %b", mem[16]);

    end

    initial begin
        clk     = 0;
        reset_n = 0;
        rdy     = 0;
        data_in = 0;

        @(posedge clk);
        reset_n = 1;

        @(posedge clk);
        rdy     = 0;
        // data_in = 8'b0000_0000;

        test(8'b0000_0000);

        #10;
        $fclose(MCD);
        $finish;
    end

    data_mod_fsm umod(   .clk(clk),
                .reset_n(reset_n),
                .rdy(rdy),
                .data_in(data_in),
                .dmod(dmod),
                .mod_en(mod_en),
                .rd(rd));
endmodule
