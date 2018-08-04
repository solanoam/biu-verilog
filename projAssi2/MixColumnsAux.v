`include "Mul.v"
`include "MulAux.v"
module MixColumnsAux #
(
parameter BYTE = 8,
parameter WORD = 32,
parameter SENTENCE = 128
)
(
input [ WORD-1 : 0 ] inpt,
output [ WORD-1 : 0 ] oupt
);
wire [ BYTE-1 : 0 ] byt1 , byt2 , byt3 , byt4 ;
wire [ BYTE-1 : 0 ] bytm1 , bytm2 , bytm3 , bytm4 ;
wire [ BYTE-1 : 0 ] bytm1_3 , bytm2_3 , bytm3_3 , bytm4_3 ;
wire [ BYTE-1 : 0 ] ouptByt1 , ouptByt2 , ouptByt3 , ouptByt4 ;
assign { byt4 , byt3 , byt2 , byt1 } = inpt ;
Mul inst1 ( byt1 , bytm1 ) ;
Mul inst2 ( byt2 , bytm2 ) ;
Mul inst3 ( byt3 , bytm3 ) ;
Mul inst4 ( byt4 , bytm4 ) ;
MulAux instAux1 ( byt1 , bytm1_3 ) ;
MulAux instAux2 ( byt2 , bytm2_3 ) ;
MulAux instAux3 ( byt3 , bytm3_3 ) ;
MulAux instAux4 ( byt4 , bytm4_3 ) ;
assign ouptByt4 = bytm4 ^ bytm3_3 ^ byt2 ^ byt1 ;
assign ouptByt3 = byt4 ^ bytm3 ^ bytm2_3 ^ byt1 ;
assign ouptByt2 = byt4 ^ byt3 ^ bytm2 ^ bytm1_3 ;
assign ouptByt1 = bytm4_3 ^ byt3 ^ byt2 ^ bytm1 ;
assign oupt = { ouptByt4 , ouptByt3 , ouptByt2 , ouptByt1 } ;
endmodule
