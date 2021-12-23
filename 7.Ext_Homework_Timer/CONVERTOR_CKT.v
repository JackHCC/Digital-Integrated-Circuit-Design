module CONVERTOR_CKT (
    input   wire[3 : 0] hours_cur,
            wire[5 : 0] mins_cur,
    
    output  reg[13 : 0] hours_disp,
                        mins_disp
);
    // digital number display
    parameter [6 : 0]    zero   = 7'b1111110;
    parameter [6 : 0]    one    = 7'b0110000;
    parameter [6 : 0]    two    = 7'b1101101;
    parameter [6 : 0]    three  = 7'b1111001;
    parameter [6 : 0]    four   = 7'b0110011;
    parameter [6 : 0]    five   = 7'b1011011;
    parameter [6 : 0]    six    = 7'b1011111;
    parameter [6 : 0]    seven  = 7'b1110000;
    parameter [6 : 0]    eight  = 7'b1111111;
    parameter [6 : 0]    nine   = 7'b1111011;
    parameter [6 : 0]    other  = 7'b0000001;

    wire [3 : 0]    mins_low    = mins_cur % 10; 
    wire [3 : 0]    mins_high   = mins_cur / 10; 
    wire [3 : 0]    hours_low   = hours_cur % 10; 
    wire [3 : 0]    hours_high  = hours_cur / 10; 

    always @(*) begin
        case(mins_low)
            4'h0:  mins_disp[6 : 0]    = zero;
            4'h1:  mins_disp[6 : 0]    = one;
            4'h2:  mins_disp[6 : 0]    = two;
            4'h3:  mins_disp[6 : 0]    = three;
            4'h4:  mins_disp[6 : 0]    = four;
            4'h5:  mins_disp[6 : 0]    = five;
            4'h6:  mins_disp[6 : 0]    = six;
            4'h7:  mins_disp[6 : 0]    = seven;
            4'h8:  mins_disp[6 : 0]    = eight;
            4'h9:  mins_disp[6 : 0]    = nine;
            default:    mins_disp[6 : 0]    = other;
        endcase     
        case(mins_high)
            4'h0:  mins_disp[13 : 7]    = zero;
            4'h1:  mins_disp[13 : 7]    = one;
            4'h2:  mins_disp[13 : 7]    = two;
            4'h3:  mins_disp[13 : 7]    = three;
            4'h4:  mins_disp[13 : 7]    = four;
            4'h5:  mins_disp[13 : 7]    = five;
            4'h6:  mins_disp[13 : 7]    = six;
            4'h7:  mins_disp[13 : 7]    = seven;
            4'h8:  mins_disp[13 : 7]    = eight;
            4'h9:  mins_disp[13 : 7]    = nine;
            default:    mins_disp[13 : 7]   = other;
        endcase   
        case(hours_low)
            4'h0:  hours_disp[6 : 0]    = zero;
            4'h1:  hours_disp[6 : 0]    = one;
            4'h2:  hours_disp[6 : 0]    = two;
            4'h3:  hours_disp[6 : 0]    = three;
            4'h4:  hours_disp[6 : 0]    = four;
            4'h5:  hours_disp[6 : 0]    = five;
            4'h6:  hours_disp[6 : 0]    = six;
            4'h7:  hours_disp[6 : 0]    = seven;
            4'h8:  hours_disp[6 : 0]    = eight;
            4'h9:  hours_disp[6 : 0]    = nine;
            default:    hours_disp[6 : 0]   = other;
        endcase     
        case(hours_high)
            4'h0:  hours_disp[13 : 7]   = zero;
            4'h1:  hours_disp[13 : 7]   = one;
            4'h2:  hours_disp[13 : 7]   = two;
            4'h3:  hours_disp[13 : 7]   = three;
            4'h4:  hours_disp[13 : 7]   = four;
            4'h5:  hours_disp[13 : 7]   = five;
            4'h6:  hours_disp[13 : 7]   = six;
            4'h7:  hours_disp[13 : 7]   = seven;
            4'h8:  hours_disp[13 : 7]   = eight;
            4'h9:  hours_disp[13 : 7]   = nine;
            default:    hours_disp[13 : 7]  = other;
        endcase      
    end
    
endmodule
