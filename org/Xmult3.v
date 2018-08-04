`include "Xmult.v" 
module Xmult3 # ( parameter BYTE = 8 , parameter WORD = 32 , parameter SENTENCE = 128 )
( input [ BYTE-1 : 0 ] in, output [ BYTE-1 : 0 ] out ) ;

wire [ BYTE-1 : 0 ] out_xmult ;

Xmult mult_by_2 ( in , out_xmult ) ; // calling to 'xmult' module (x*in) 

assign out = out_xmult ^ in ; // xor between the xmult_output and the input (x*in + in)

endmodule
