`include "Sbox.v" 

module SubWord # ( parameter BYTE = 8 , parameter WORD = 32 , parameter SENTENCE = 128 )
( input [ WORD-1 : 0 ] in , output [ WORD-1 : 0 ] out ) ;
	Sbox sbox_a ( in [ BYTE-1 : 0 ] , out [ BYTE-1 : 0 ] ) ;
	Sbox sbox_b ( in [ 2*BYTE-1 : BYTE ] , out [ 2*BYTE-1 : BYTE ] ) ;
	Sbox sbox_c ( in [ 3*BYTE-1 : 2*BYTE ] , out [ 3*BYTE-1 : 2*BYTE ] ) ;
	Sbox sbox_d ( in [ WORD-1:3*BYTE ] , out [ WORD-1 : 3*BYTE ] ) ; 

endmodule