`include "MixColumns.v" 
`include "ShiftRows.v"
`include "SubBytes.v" 
`include "Mux_3to1.v" 
`include "AddRoundKey.v" 
`include "KeyExpansion.v"
`include "State_Machine.v" 

module AES_cipher # ( parameter BYTE = 8 , parameter WORD = 32 , parameter SENTENCE = 128 )
( input CLK , input Start , input [ SENTENCE-1 : 0 ] Plain_Text , input [ SENTENCE-1 : 0 ] Key , 
output reg [ SENTENCE-1 : 0 ] Cipher_Text , output Done ) ;

reg [ SENTENCE-1 : 0 ] Round_Key ,  In_Pipe ;   //in pipe is the text in thr pipe
wire  [ SENTENCE-1 : 0 ]  sb_out , sr_out , mc_out , mux_out , ark_out , nrk_out ;
wire [ 3 : 0 ] Round_Num ;


SubBytes a ( In_Pipe , sb_out ) ;
ShiftRows b ( sb_out , sr_out ) ;
MixColumns c ( sr_out , mc_out) ;
Mux_3to1 d ( Round_Num , mc_out, sr_out , Plain_Text , mux_out ) ;
AddRoundKey e ( mux_out , Round_Key , ark_out ) ;
KeyExpansion f ( Round_Key , Round_Num , nrk_out ) ;
State_Machine g ( CLK , Start , Done , Round_Num ) ;



always @( Plain_Text or Key or Start) begin
	if( Round_Num == 0 ) begin
		Round_Key = Key ;
	end
end

always @( posedge CLK ) begin
	Round_Key = nrk_out ;
	
	In_Pipe = ark_out ;
	Cipher_Text  = ( Round_Num == 10 ) ? ark_out  : 128'bxxxx ;
end	
endmodule