module AddRoundKey # ( parameter BYTE = 8 , parameter DWORD = 32 , parameter PHRASE = 128 )
input [ SENTENCE-1 : 0 ] in
input [ SENTENCE-1 : 0 ] state
output [ SENTENCE-1 : 0 ] out

assign out = in ^ state ;
endmodule
