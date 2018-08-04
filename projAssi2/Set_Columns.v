module Set_Columns #
(
parameter BYTE = 8 ,
parameter DWORD = 32 ,
parameter LENGTH = 128
)
(
input [ DWORD-1 : 0 ] in,
output [ DWORD-1 : 0 ] out
);
  wire [ BYTE-1 : 0 ] B1 , B2 , B3 , B4 ;
  wire [ BYTE-1 : 0 ] Bmult1 , Bmult2 , Bmult3 , Bmult4 ;
  wire [ BYTE-1 : 0 ] Bmult1_3 , Bmult2_3 , Bmult3_3 , Bmult4_3 ;
  wire [ BYTE-1 : 0 ] out_b1 , Out_B2 , Out_B3 , Out_B4 ;
  assign { B4 , B3 , B2 , B1 } = in ; // concatenation from the input to 4 bytes
  assign Bmult1 = (!B1[BYTE-1]) ? {B1[BYTE-2:0],1'b0} : {B1[BYTE-2:0],1'b0} ^ 8'h1B;
  assign Bmult2 = (!B2[BYTE-1]) ? {B2[BYTE-2:0],1'b0} : {B2[BYTE-2:0],1'b0} ^ 8'h1B;
  assign Bmult3 = (!B3[BYTE-1]) ? {B3[BYTE-2:0],1'b0} : {B3[BYTE-2:0],1'b0} ^ 8'h1B;
  assign Bmult4 = (!B4[BYTE-1]) ? {B4[BYTE-2:0],1'b0} : {B4[BYTE-2:0],1'b0} ^ 8'h1B;
  assign Bmult1_3 = Bmult1 ^ B1 ;
  assign Bmult2_3 = Bmult2 ^ B2 ;
  assign Bmult3_3 = Bmult3 ^ B3 ;
  assign Bmult4_3 = Bmult4 ^ B4 ;
  assign Out_B4 = Bmult4 ^ Bmult3_3 ^ B2 ^ B1 ; // msb
  assign Out_B3 = B4 ^ Bmult3 ^ Bmult2_3 ^ B1 ; // smaller byte msb
  assign Out_B2 = B4 ^ B3 ^ Bmult2 ^ Bmult1_3 ; // bigger byte lsb
  assign Out_B1 = Bmult4_3 ^ B3 ^ B2 ^ Bmult1 ; // lsb
  assign Out = { Out_B4 , Out_B3 , Out_B2 , Out_B1 } ; // concatenation the 4 bytes to word and output
endmodule
