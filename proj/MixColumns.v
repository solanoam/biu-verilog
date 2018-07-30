`include "Set_Columns.v"
module MixColumns # (parameter BYTE = 8 , parameter WORD = 32 , parameter SENTENCE = 128 )
( input [ SENTENCE-1 : 0 ] in , output [ SENTENCE-1 : 0 ] out ) ;
wire [ WORD-1 : 0 ] W0 , W1 , W2 , W3 ;
wire [ WORD-1 : 0 ] WA0 , WA1 , WA2 , WA3 ;
assign { W3 , W2 , W1 , W0 } = in ; // concatenation from the input to 4 words
	
	// calling to 'set columns' module 
	Set_Columns set0 ( W0 , WA0 ) ; // lsb
	Set_Columns set1 ( W1 , WA1 ) ; // bigger word than lsb
	Set_Columns set2 ( W2 , WA2 ) ; // smaller word than msb
	Set_Columns set3 ( W3 , WA3 ) ; // msb
	
// concatenation from the 4 bytes of the output set_columns to output
assign out = { WA3 , WA2 , WA1 , WA0 } ;  
endmodule