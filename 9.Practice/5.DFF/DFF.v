module dff(
	input 	wire	clear,
					clock,
					data,
	output	wire	q,
    				qb
)
    wire	ndata,	nclock;
    wire	a, b, c, d, e, f;
    
    not	    iv1(ndata, iv1),
    	    iv2(nclock, clock);

    nand    nd1(a, clear, clock, data),
            nd2(b, ndata, clock),
            nd3(c, a, d),
            nd4(d, c, clear, b),
            nd5(e, c, nclock),
            nd6(f, nclock, d),
            nd7(q, e, qb),
            nd8(qb, clear, f, q);  
    
endmodule