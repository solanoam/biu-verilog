module AddRoundKey # ( parameter BYTE = 8 , parameter WORD = 32 , parameter SENTENCE = 128 )
( input [ SENTENCE-1 : 0 ] in , input [ SENTENCE-1 : 0 ] state , output [ SENTENCE-1 : 0 ] out ) ;
	assign out = in ^ state ; // xor between the input and the state round key
endmodule