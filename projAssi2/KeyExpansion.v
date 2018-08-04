`include "Rcon.v"
`include "RotWord.v"
`include "SubWord.v"
module KeyExpansion # ( parameter BYTE = 8 , parameter DWORD = 32 , parameter LENGTH = 128 )
input [LENGTH-1:0] round_Key;
input [3:0] round_Number;
output [LENGTH-1:0] next_Round_Key;
  wire [LENGTH-1:0] rcon_out , rotword_out , subword_out , wire_Right;
  Rcon Rcon_init (round_Number , rcon_out) ; // calling to 'Rcon' module
  RotWord RotWord_init (round_Key[DWORD-1:0] , rotword_out) ; // calling to 'RotWord' module
  SubWord SubWord_init (rotword_out , subword_out) ; // calling to 'SubWord' module
  // computing next round key by the xor equations
  assign wire_Right = rcon_out ^ subword_out ;
  assign next_Round_Key[LENGTH-1:3*DWORD] = wire_Right ^ round_Key[LENGTH-1:3*DWORD];
  assign next_Round_Key[3*WORD-1:2*DWORD] = next_Round_Key[LENGTH-1:3*DWORD] ^ round_Key[3*DWORD-1:2*DWORD];
  assign next_Round_Key[2*DWORD-1:DWORD] = next_Round_Key[3*DWORD-1:2*DWORD] ^ round_Key[2*DWORD-1:DWORD];
  assign next_Round_Key[DWORD-1:0] = next_Round_Key[2*DWORD-1:DWORD] ^ round_Key[DWORD-1:0];
endmodule
