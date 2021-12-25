`timescale 1ns/1ns
module FIFO_tb ();
    reg [7 : 0] data_in;
    reg         clk,
                reset_n,
                rd_en,
                wr_en;
    wire[7 : 0] data_o;
    wire        empty,
                full;


    always #5 clk = ~clk;

    initial begin
        reset_n = 0;
        clk = 0;
        wr_en = 0;
        rd_en = 0;
        data_in = 8'h11;

        @(negedge clk);
        reset_n = 1;

        @(posedge clk);
        wr_en <= 0; // only write but not read
        rd_en <= 0;

        repeat(4) begin
            @(posedge clk);
            data_in <= data_in + 1;
            wr_en <= !wr_en; // only write but not read
        end

        @(posedge clk);
        wr_en <= 0; // only read but not write
        rd_en <= 0;

        repeat(4) begin
            @(posedge clk);
            rd_en <= !rd_en;
        end

        @(posedge clk);
        wr_en <= 0; // not read or write
        rd_en <= 0;

        #10;
        $finish;
    end

    FIFO ufifo( .clk(clk),
                .reset_n(reset_n),
                .rd_en(rd_en),
                .wr_en(wr_en),
                .data_in(data_in),
                .data_o(data_o),
                .empty(empty),
                .full(full));
endmodule