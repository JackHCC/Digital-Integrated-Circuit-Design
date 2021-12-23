`timescale 1ns/1ns
module ALU4_tb_auto();
    reg [3:0]   a,
                b;
    reg         ci;
    reg         M;
    reg [3:0]   S;
    wire[3:0]   Do; 
    wire        co;
    wire        V,
                Z;
    ALU4 uG(.a ( a ),
            .b ( b ),
            .cin ( ci ),
            .M ( M ),
            .S ( S ),
            .do ( Do ), 
            .co ( co ),
            .V ( V ),
            .Z ( Z ));

    integer     i;
    reg         error ;
    integer     func ;
    reg [3 : 0] DO_ex;
    reg [3 : 0] opA,
                opB;
    initial begin
        //logic test
        func = 0;
        error = 0;
        a = 4'b1100;
        b = 4'b1010;
        ci= 1'b1;
        M = 1'b0;
        for(i = 0; i < 16; i = i+1) begin
            S = i;
            #10 if( Do != DO_ex) 
                    error = 1;
                else
                    error = 0;
        end 
    //add test
    func = func + 1;
    S = 4'b1001; ci = 1'b0; M = 1'b1;
        for(i = 0; i < 256; i = i+1) begin
            {a, b} = i;
            #10 if(Do != DO_ex) 
                    error = 1;
                else
                    error = 0;
        end
    
    //sub test
    func = func + 1;
    S = 4'b0110; ci = 1'b1; M = 1'b1;
    a = 4'b1100;
    b = 4'b1010;
    #10 if(Do != DO_ex) 
            error = 1;
        else
            error = 0;
    
    //carry test
    func = func + 1;
    S = 4'b1001; ci = 1'b0; M = 1'b1;
    a = 4'b1100;
    b = 4'b0110;
    #10 if(co == 1'b0) 
            error = 1;
        else
            error = 0;

    a = 4'b0100;
    b = 4'b0110;
    #10 if(co == 1'b1) 
            error = 1;
        else
            error = 0;
    
    //V test
    //a + b
    // a = 4'b0111; b = 4'b0010 V = 1
    // a = 4'b0111; b = 4'b1010 V = 0
    // a = 4'b1100; b = 4'b1010 V = 1
    // a = 4'b1100; b = 4'b0110 V = 0
    func = func + 1;
    S = 4'b1001; ci = 1'b0; M = 1'b1;
    a = 4'b0111;
    b = 4'b0010;
    #10 if(V == 1'b0) 
            error = 1;
        else
            error = 0;
    a = 4'b0111;
    b = 4'b1010;
    #10 if(V == 1'b1) 
            error = 1;
        else
            error = 0;
    a = 4'b1100;
    b = 4'b1010;
    #10 if(V == 1'b0) 
            error = 1;
        else
            error = 0;
    a = 4'b1100;
    b = 4'b0110;
    #10 if(V == 1'b1) 
            error = 1;
        else
            error = 0;

    //a - b
    // a = 4'b0111; b = 4'b0010 V = 0
    // a = 4'b0111; b = 4'b1010 V = 1
    // a = 4'b1100; b = 4'b1010 V = 0
    // a = 4'b1100; b = 4'b0110 V = 1
    func = func + 1;
    S = 4'b0110; ci = 1'b1; M = 1'b1;
    a = 4'b0111;
    b = 4'b0010;
    #10 if(V == 1'b1) 
            error = 1;
        else
            error = 0;
    a = 4'b0111;
    b = 4'b1010;
    #10 if(V == 1'b0) 
            error = 1;
        else
            error = 0;
    
    a = 4'b1100;
    b = 4'b1010;
    #10 if(V == 1'b1) 
            error = 1;
        else
            error = 0;
    a = 4'b1100;
    b = 4'b0110;
    #10 if(V == 1'b0) 
            error = 1;
        else
            error = 0;
    #10 $finish;
    end   
    
    //DO expected
    always @(*) begin
        opA = a;
        opB = b;
        case({S, ci, M})
            //0000 10 0 置全0
            //0001 10 !A & !B nor
            //0010 10 !A & B notand
            //0011 10 !A not A
            6'b0000_10: DO_ex = 32'b0;
            6'b0001_10: DO_ex = ~opA & ~opB;
            6'b0010_10: DO_ex = ~opA & opB;
            6'b0011_10: DO_ex = ~opA;
            //0100 10 A & !B andnot
            //0101 10 !B not B
            //0110 10 A&!B | !A&B xor
            //0111 10 !A | !B nand
            6'b0100_10: DO_ex = opA & ~opB;
            6'b0101_10: DO_ex = ~opB;
            6'b0110_10: DO_ex = opA ^ opB;
            6'b0111_10: DO_ex = ~opA | ~opB;
            //1000 10 A & B and
            //1001 10 A&B | !A & !B xnor
            //1010 10 B 传送B
            //1011 10 A&B | !A&B |!A&!B notor 
            6'b1000_10: DO_ex = opA & opB;
            6'b1001_10: DO_ex = opA ~^ opB;
            6'b1010_10: DO_ex = opB;
            6'b1011_10: DO_ex = ~(opA & ~opB);
            //1100 10 A 传送A
            //1101 10 A&B | A&!B | !A&!B or not
            //1110 10 A&B | A&!B | !A&B or 
            //1111 10 1 置全1
            6'b1100_10: DO_ex = opA ;
            6'b1101_10: DO_ex = ~(~opA & opB);
            6'b1110_10: DO_ex = opA | opB;
            6'b1111_10: DO_ex = {32{1'b1}};
            //1001 01 A ^ B ^ C 加法
            //0110 11 ( A ~^ B) ^ C 减法
            6'b1001_01: DO_ex = opA + opB;
            6'b0110_11: DO_ex = opA - opB;
            default: DO_ex = 32'bx;
        endcase
    end
endmodule