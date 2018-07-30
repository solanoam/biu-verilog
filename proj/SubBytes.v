`include "SubWord.v" 
module SubBytes # ( parameter BYTE = 8 , parameter WORD = 32 , parameter SENTENCE = 128 )
( input [ SENTENCE-1 : 0 ] in , output [ SENTENCE-1 : 0 ] out ) ;

genvar index ;
generate
	for ( index = 1 ; index <= 4 ; index = index + 1) begin : SubBytes_loop
		SubWord SW ( in [ index*WORD-1 : ( index-1 )*WORD ] , out [ index*WORD-1 : ( index-1 )*WORD ] ) ;
	end
endgenerate

endmodule