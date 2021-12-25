`timescale 1ns/1ns
module Counter (
    input   wire        clk,
                        rst,
    output  wire[2 : 0] Y 
);
    reg             Q1,
                    Q0;

    // DFF's Q is usually in process block
    always @(posedge clk, posedge rst) begin
        if(rst) begin
            Q0 <= 0;
            Q1 <= 0;
        end
        else begin
            Q0 <= ~Q0;
            Q1 <= Q0 ^ Q1;
        end   
    end

    // Output is always using to combination circuit
    assign Y[0]= Q0 | Q1;
    assign Y[1]= Q0;
    assign Y[2]= Q1; 
endmodule
