module ShiftRows # ( parameter BYTE = 8 , parameter WORD = 32 , parameter SENTENCE = 128 )
( input [ SENTENCE-1 : 0] in , output [ SENTENCE-1 : 0 ] out ) ;


// concatenation the input to the output to the corrct order
assign out = {	in[16*BYTE-1:15*BYTE] , in[11*BYTE-1 : 10*BYTE] , in[6*BYTE-1 : 5*BYTE] , in[BYTE-1 : 0] ,
				in[12*BYTE-1 : 11*BYTE] , in[7*BYTE-1 : 6*BYTE] , in[2*BYTE-1 : BYTE], in[13*BYTE-1 : 12*BYTE] ,
				in[8*BYTE-1 : 7*BYTE] , in[3*BYTE-1 : 2*BYTE] , in[14*BYTE-1 : 13*BYTE] , in[9*BYTE-1 : 8*BYTE] ,
				in[4*BYTE-1 : 3*BYTE] , in[15*BYTE-1 : 14*BYTE] , in[10*BYTE-1 : 9*BYTE] , in[5*BYTE-1 : 4*BYTE] } ;

endmodule