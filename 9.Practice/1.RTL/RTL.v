`timescale 1ns/1ns
module RTL (
    input   wire        sr,
                        sl,
                        ld,
                        D_sr,
                        D_sl,
                        clk,
                [3 : 0] D,
    output  reg [3 : 0] Q
);

    wire [3 : 0]    sr_buf,
                    sl_buf;
    wire [3 : 0]    D_in;

    assign  sr_buf[3]       = D_sr;
    assign  sr_buf[2 : 0]   = Q[3 : 1]; 
    assign  sl_buf[0]       = D_sl;
    assign  sl_buf[3 : 1]   = Q[2 : 0];

    assign  D_in    =   ( sr_buf & {4{sr}} ) | 
                        ( D & {4{ld}}) |
                        ( sl_buf & {4{sl}}); 

    always @(posedge clk) begin
        Q <= D_in;   
    end

endmodule