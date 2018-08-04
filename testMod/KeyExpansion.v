`include "Rcon.v"
`include "RotWord.v"
`include "SubWord.v"

module KeyExpansion # ( parameter BYTE = 8 , parameter WORD = 32 , parameter SENTENCE = 128 )
( input [ SENTENCE-1 : 0 ] round_Key , input [ 3 : 0 ] round_Number , output [ SENTENCE-1 : 0 ] next_Round_Key ) ;

wire [ WORD-1 : 0 ] rcon_out , rotword_out , subword_out , wire_Right ;

Rcon a ( round_Number , rcon_out ) ; // calling to 'Rcon' module

RotWord b ( round_Key [ WORD-1 : 0 ] , rotword_out ) ; // calling to 'RotWord' module
SubWord c ( rotword_out , subword_out ) ; // calling to 'SubWord' module


// computing next round key by the xor equations
assign wire_Right = rcon_out ^ subword_out ;

assign next_Round_Key [ SENTENCE-1 : 3*WORD ] = wire_Right ^ round_Key [ SENTENCE-1 : 3*WORD ] ;

assign next_Round_Key [ 3*WORD-1 : 2*WORD ] = next_Round_Key [ SENTENCE-1 : 3*WORD ] ^ round_Key [ 3*WORD-1 : 2*WORD ] ;

assign next_Round_Key [ 2*WORD-1 : WORD ] = next_Round_Key [ 3*WORD-1 : 2*WORD ] ^ round_Key [ 2*WORD-1 : WORD ] ;

assign next_Round_Key [ WORD-1 : 0 ] = next_Round_Key [ 2*WORD-1 : WORD ] ^ round_Key [ WORD-1 : 0 ] ;

endmodule
