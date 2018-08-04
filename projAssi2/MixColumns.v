`include "MixColumnsAux.v"
module MixColumns # (
parameter BYTE = 8,
parameter DWORD = 32,
parameter LENGTH = 128
)
(
input [ LENGTH-1 : 0 ] inpt,
output [ LENGTH-1 : 0 ] oupt
);
	wire [ DWORD-1 : 0 ] wrd0 , wrd1 , wrd2 , wrd3 ;
	wire [ DWORD-1 : 0 ] wrdOpt0 , wrdOpt1 , wrdOpt2 , wrdOpt3 ;
	assign { wrd3 , wrd2 , wrd1 , wrd0 } = inpt ;
	MixColumnsAux col0 ( wrd0 , wrdOpt0 ) ;
	MixColumnsAux col1 ( wrd1 , wrdOpt1 ) ;
	MixColumnsAux col2 ( wrd2 , wrdOpt2 ) ;
	MixColumnsAux col3 ( wrd3 , wrdOpt3 ) ;
	assign oupt = { wrdOpt3 , wrdOpt2 , wrdOpt1 , wrdOpt0 } ;
endmodule
