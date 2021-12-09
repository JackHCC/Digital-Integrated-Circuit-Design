`timescale 1ns/1ps
module mod(
	input 	wire[7 : 0]	data_in,
	input	wire		clk,
						rst_n,
						rdy,
	output	reg	[4 : 0]	dmod,
	output	wire		rd,
						mod_en
	);


	reg     [3 : 0] state;
    reg     [7 : 0] buffer;
	reg 	[7 : 0] temp;
	reg 			flag;
	reg 			m_en;
    
    parameter   s_0		= 4'b0000,
				s_3_5  	= 4'b0001,
                s_1_5_2 = 4'b0010,
				s_1_5	= 4'b0011,
                s_4_4   = 4'b0100,
                s_2_5_1 = 4'b0101,
				s_2_5	= 4'b0110,
                s_5_3   = 4'b0111,
				s_5 	= 4'b1000; 

	always @(posedge clk, negedge rst_n)
		if(!rst_n) begin
			state 	<= 0;
			buffer 	<= 0;
			temp 	<= 0;
			flag 	<= 0;
			m_en	<= 0;
		end
		else 
			if(!rdy)
				case(state)
					s_0: begin
						buffer 	= 0;
						temp 	= 0;
						flag 	= 0;
						m_en	= 0;
						state	= s_3_5;
					end
					s_3_5:	begin
						buffer 	= data_in;
						dmod	= buffer[4 : 0];
						temp	= buffer[7 : 5];
						flag	= 0;
						m_en	= 1;
						state	= s_1_5_2;
					end
					s_1_5_2: begin
						buffer	= data_in;
						dmod	= {buffer[1 : 0], temp[2 : 0]};
						temp	= buffer[7 : 2];
						flag	= 1;
						m_en	= 1;
						state	= s_1_5;
					end
					s_1_5:	begin
						dmod	= temp[4 : 0];
						temp	= temp[5];
						flag	= 0;
						m_en	= 1;
						state	= s_4_4;
					end
					s_4_4: begin
						buffer	= data_in;
						dmod	= {buffer[3 : 0], temp[0]};
						temp	= buffer[7 : 4];
						flag	= 0;
						m_en	= 1;
						state	= s_2_5_1;
					end
					s_2_5_1: begin
						buffer	= data_in;
						dmod	= {buffer[0], temp[3 : 0]};
						temp	= buffer[7 : 1];
						flag	= 1;
						m_en	= 1;
						state	= s_2_5;
					end
					s_2_5: begin
						dmod	= temp[4 : 0];
						temp	= temp[6 : 5];
						flag	= 0;
						m_en	= 1;
						state	= s_5_3;
					end
					s_5_3: begin
						buffer	= data_in;
						dmod	= {buffer[2 : 0], temp[1 : 0]};
						temp	= buffer[7 : 3];
						flag	= 1;
						m_en	= 1;
						state	= s_5;
					end
					s_5: begin
						dmod	= temp[4 : 0];
						m_en	= 1;
						flag	= 1;
						state	= s_3_5;
					end
				endcase
			else
				case(state)
					s_1_5: begin
						dmod	= temp[4 : 0];
						temp	= temp[5];
						flag	= 0;
						m_en	= 1;
						state	= s_4_4;
					end
					s_2_5: begin
						dmod	= temp[4 : 0];
						temp	= temp[6 : 5];
						flag	= 0;
						m_en	= 1;
						state	= s_5_3;
					end
					s_5: begin
						dmod	= temp[4 : 0];
						m_en	= 0;
						flag	= 1;
						state	= s_3_5;
					end
					s_1_5_2: begin
						flag	= 1;
						m_en	= 0;
					end
					s_2_5_1: begin
						flag	= 1;
						m_en	= 0;
					end
					s_5_3: begin
						flag	= 1;
						m_en	= 0;
					end
					default: begin
						m_en	= 0;
						flag	= 0;
					end
				endcase
	
	assign	mod_en = m_en;

	assign	rd	= !flag & !rdy;

endmodule
// `timescale 1ns/1ps
// module mod(
// 	input 	wire	[7 : 0]	data_in,
// 	input	wire		clk,
// 				rst_n,
// 				rdy,
// 	output	reg	[4 : 0]	dmod,
// 	output	reg		rd,
// 				mod_en
// 	);

// 	reg	[22 : 0]	buffer,
// 				count;

// 	always @(posedge clk)
// 	begin
// 		if(!rst_n) begin
// 			buffer <= 0;
// 			count <= 0;
// 		end
// 	end

// 	always @(posedge clk)
// 	begin
// 		if(!rdy) begin
// 			if(!count) begin
// 				buffer = data_in;
// 				count = count + 8;
// 			end
// 			else begin
// 				buffer = buffer + data_in<<count; 
// 				count = count + 8;
// 			end
// 		end 
// 	end

// 	always @(posedge clk)
// 	begin
// 		if(count >=5) begin
// 			dmod = buffer[4 : 0];
// 			buffer = buffer>>5;
// 			mod_en = 1;
// 			count = count - 5;
// 		end
// 		else begin
// 			dmod <= 0;
// 			mod_en <= 0;
// 		end
// 	end

	
// 	always @(posedge clk)
// 	begin
// 		rd <= !rdy;
// 	end
		

// endmodule
