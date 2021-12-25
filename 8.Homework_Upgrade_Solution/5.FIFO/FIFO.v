`timescale 1ns/1ns
module FIFO #(
    parameter   DEPTH       = 6,
                WIDTH       = 8,
                MAX_COUNT   = 1 << DEPTH
)(
    input   wire [7 : 0]    data_in,
            wire            wr_en,
                            rd_en,
                            clk,
                            reset_n,
    output  wire [7 : 0]    data_o,
            wire            full,
                            empty
);

    reg [DEPTH-1 : 0]   head,
                        tail,
                        count;
    reg [WIDTH-1 : 0]   mem[MAX_COUNT : 0];

    wire [1 : 0]    bind;

    assign bind     = {wr_en, rd_en};
    assign data_o   = rd_en? mem[tail] : 8'bz;

    always @(posedge wr_en) begin
        mem[head]   = data_in;
    end  

    always @(posedge clk, negedge reset_n) begin
        if(!reset_n) begin
            head    <= 0;
            tail    <= 0;
            count   <= 0;
        end
        else
            if(wr_en)
                head    = head + 1;
                count   = count + 1;
            if(rd_en)
                tail    = tail + 1;
                count   = count - 1;
    end

    assign empty    = count < MAX_COUNT/4;
    assign full     = count > 3*MAX_COUNT/4;
endmodule
