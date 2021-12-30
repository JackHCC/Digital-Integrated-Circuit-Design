`timescale 1ns/1ns
module SRAM_tb ();
    reg         read,
                write;
    reg [4 : 0] addr;
    wire[7 : 0] data;

    reg [7 : 0] data_buf;


    SRAM u( .addr(addr),
            .data(data),
            .write(write),
            .read(read));

    assign data = write? data_buf : 8'bz;

    task wr;
        input [4 : 0] address;
        input [7 : 0] dat;
        
        begin
            addr    = address;
            #1  data_buf    = dat;
            #2  write       = 1;
            #4  write       = 0;
            #1  data_buf    = 8'bz;
            #1;    
        end
    endtask

    task rd;
        input [4 : 0] address;
        begin
            addr    = address;
            #3  read        = 1;
            #4  read        = 0;
            #2;
        end
    endtask

    initial begin
        write   = 0;
        read    = 0;
        data_buf= 0;
        addr    = 0;

        wr(5'h12, 8'h55);
        wr(5'h13, 8'hAA);
        rd(5'h12);
        rd(5'h13);

        #10 $finish;
    end        
            
endmodule
