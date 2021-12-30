`timescale 1ns/1ns
module SRAM #(
    parameter Width = 5,
    parameter Max   = 1 << Width
)(
    input wire          read,
                        write,
    input wire  [Width-1 : 0]   addr,
    inout wire  [7 : 0]         data
);

    reg [7 : 0] mem[Max-1 : 0];     

    assign #1 data = read? mem[addr] : 8'bz;    // 注意这里有延时1ns

    always @(posedge write) begin
        mem[addr]   = data;    
    end
     
endmodule
