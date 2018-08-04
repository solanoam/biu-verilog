module RotWord # ( parameter BYTE = 8 , parameter WORD = 32 , parameter SENTENCE = 128 )
( input [ WORD-1:0 ] in , output [ WORD-1 : 0 ] out ) ;
	//shift left cyclic byte of the input  
	assign out = { in [ 23 : 16 ] , in [ 15 : 8 ] , in [ 7 : 0 ] , in [ 31 : 24 ] } ;
endmodule





