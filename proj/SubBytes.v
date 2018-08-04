`include "SubWord.v"
module SubBytes # ( parameter BYTE = 8 , parameter DWORD = 32 , parameter LENGTH = 128 )
( input [ LENGTH-1 : 0 ] in , output [ LENGTH-1 : 0 ] out ) ;

genvar index ;
generate
	for ( index = 1 ; index <= 4 ; index = index + 1) begin : SubBytes_loop
		SubWord SW ( in [ index*DWORD-1 : ( index-1 )*DWORD ] , out [ index*WORD-1 : ( index-1 )*DWORD ] ) ;
	end
endgenerate

endmodule
