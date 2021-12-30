module FSM2 (
    input   wire    clk,
                    clr,
    output  wire    Q0,
                    Q1,
                    Q2
);

    reg     Q0_o,
            Q1_o,
            Q2_o;

    always @(posedge clk, posedge clr) begin
        if(clr) begin
            Q0_o    <= 0;
            Q1_o    <= 0;
            Q2_o    <= 0;
        end
        else begin
            Q0_o    <= ~Q0_o;
            Q1_o    <= Q1_o ^ Q0_o;
            Q2_o    <= (Q1_o & Q0_o) ^ Q2_o;
        end
    end 

    assign  Q0  = Q0_o;
    assign  Q1  = Q1_o;
    assign  Q2  = Q2_o;
    
endmodule
