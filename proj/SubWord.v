`include "Sbox.v"
module SubWord # ( parameter BYTE = 8 , parameter DWORD = 32 , parameter LENGTH = 128 )
input [ DWORD-1 : 0 ] in;
output [ DWORD-1 : 0 ] out;
	Sbox sbox_a (in[BYTE-1:0] , out [BYTE-1:0]) ;
	Sbox sbox_b (in[2*BYTE-1:BYTE] , out[2*BYTE-1:BYTE]);
	Sbox sbox_c (in[3*BYTE-1:2*BYTE] , out[3*BYTE-1:2*BYTE]);
	Sbox sbox_d (in[4*BYTE-1:3*BYTE] , out[4*BYTE-1:3*BYTE]);
endmodule
