`include "Rcon.v"
`include "RotWord.v"
`include "SubWord.v"
module KeyExpansion #
(
parameter BYTE = 8,
parameter DWORD = 32,
parameter LENGTH = 128
)
(
input [LENGTH-1:0] round_Key,
input [3:0] roundNum,
output [LENGTH-1:0] nkey
);
  wire [DWORD-1:0] rcOut , rotOut , subOut , rightWire;
  Rcon Rcon_init (roundNum , rcOut) ;
  RotWord RotWord_init (round_Key[DWORD-1:0] , rotOut) ;
  SubWord SubWord_init (rotOut , subOut) ;
  assign rightWire = rcOut ^ subOut ;
  assign nkey[LENGTH-1:3*DWORD] = rightWire ^ round_Key[LENGTH-1:3*DWORD];
  assign nkey[3*DWORD-1:2*DWORD] = nkey[LENGTH-1:3*DWORD] ^ round_Key[3*DWORD-1:2*DWORD];
  assign nkey[2*DWORD-1:DWORD] = nkey[3*DWORD-1:2*DWORD] ^ round_Key[2*DWORD-1:DWORD];
  assign nkey[DWORD-1:0] = nkey[2*DWORD-1:DWORD] ^ round_Key[DWORD-1:0];
endmodule
