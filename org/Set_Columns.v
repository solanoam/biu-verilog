module Set_Columns # ( parameter BYTE = 8 , parameter WORD = 32 , parameter SENTENCE = 128 )
( input [ WORD-1 : 0 ] in, output [ WORD-1 : 0 ] Out ) ;

wire [ BYTE-1 : 0 ] B1 , B2 , B3 , B4 ;

wire [ BYTE-1 : 0 ] Bmult1 , Bmult2 , Bmult3 , Bmult4 ;

wire [ BYTE-1 : 0 ] Bmult1_3 , Bmult2_3 , Bmult3_3 , Bmult4_3 ;

wire [ BYTE-1 : 0 ] Out_B1 , Out_B2 , Out_B3 , Out_B4 ;

assign { B4 , B3 , B2 , B1 } = in ; // concatenation from the input to 4 bytes


// calling to xmult and xmult3 for the 4 bytes from the input
Xmult a1 ( B1 , Bmult1 ) ;
Xmult3 a1_3 ( B1 , Bmult1_3 ) ;

Xmult a2 ( B2 , Bmult2 ) ;
Xmult3 a2_3 ( B2 , Bmult2_3 ) ;

Xmult a3 ( B3 , Bmult3 ) ;
Xmult3 a3_3 ( B3 , Bmult3_3 ) ;

Xmult a4 ( B4 , Bmult4 ) ;
Xmult3 a4_3 ( B4 , Bmult4_3 ) ;

// computing the 4 equations of mix columns
assign Out_B4 = Bmult4 ^ Bmult3_3 ^ B2 ^ B1 ; // msb

assign Out_B3 = B4 ^ Bmult3 ^ Bmult2_3 ^ B1 ; // smaller byte msb

assign Out_B2 = B4 ^ B3 ^ Bmult2 ^ Bmult1_3 ; // bigger byte lsb

assign Out_B1 = Bmult4_3 ^ B3 ^ B2 ^ Bmult1 ; // lsb

assign Out = { Out_B4 , Out_B3 , Out_B2 , Out_B1 } ; // concatenation the 4 bytes to word and output

endmodule
