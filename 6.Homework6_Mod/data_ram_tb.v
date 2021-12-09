`timescale 1ns/1ps
module data_ram_tb();
reg		reset_n,
		start,
		clk,
		byte;
		// read_en;
reg	    [7 : 0]	data_in;
wire  	[4 : 0]	dmod;     
wire 	        mod_en,        	
	            rd,
                full;

	always	#5	clk = !clk;

	integer i,j;

	initial begin
        clk     = 0;
        reset_n = 0;
        data_in = 2'h00;
	    start	= 0;
	    // read_en = 0;
	    byte	= 0;

	    @(posedge clk) begin
            reset_n = 1;
            data_in  = 2'h01;
            start   = 1;
            byte	= 1;
		end
	    // @(posedge clk) begin
        //     data_in  = 2'h01;
        //     start	= 1;
        //     byte	= 0;
		// end
    	for(j=0; j < 4; j=j+1)
		    for(i=0; i < 15; i=i+1) begin
			@(posedge clk);
				if(!full)
					start	<= 1;
				else
					start	<= 0;
				byte	<= 1;
				data_in <= data_in + 1;
                
		    end

	// @(posedge clk);
	// 	read_en <= 1'b1;
	// 	start <= 1'b0;

	// for(j=0; j < 3; j=j+1)
	// 	for(i=0; i < 16; i=i+1)
	// 		@(posedge clk);
	// 			if(!empty)
	// 				read_en	<= 1;
	// 			else begin
	// 				read_en	<= 0;
	// 			    data_in <= 0;
    //             end

	    #20 $finish;
    end

data_ram uu(.reset_n(reset_n),
			.clk(clk),
			.start(start),
			.byte(byte),
			.data_in(data_in),
			.dmod(dmod),
			.mod_en(mod_en),
            .rd(rd),
			.full(full));

endmodule
