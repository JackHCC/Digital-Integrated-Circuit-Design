`timescale 1ns/1ns
module CLA4_tb();
    reg [3 : 0] a,
                b;
    wire[3 : 0] s;
    wire        co;
    reg         ci;

    initial begin
        #10 a   = 4'b0000;
            b   = 4'b0000;
            ci  = 1'b0;
        $display("1-s: %b", s);

        #10 a   = 4'b0011;
            b   = 4'b0011;
            ci  = 1'b0;
        $write("1-s: %b \n", s);

        #10 a   = 4'b1100;
            b   = 4'b1100;
            ci  = 1'b1;
        $strobe("1-s: %b", s);

        #10 a   = 4'b1100;
            b   = 4'b0011;
            ci  = 1'b1;
        $display("1-s: %b", s);

        #10 a   = 4'b1111;
            b   = 4'b1111;
            ci  = 1'b0;
        $display("1-s: %b", s);

        #10;

        $finish;  
    end
    
    CLA4 u_cla4(.a(a),
                .b(b),
                .co(co),
                .s(s),
                .ci(ci));

endmodule