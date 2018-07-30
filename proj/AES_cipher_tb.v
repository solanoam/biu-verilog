`include "AES_cipher.v"

module AES_cipher_tb() ;

reg[127:0] Plain_Text, Key ;
reg CLK, Start ;
wire[127:0] Cipher_Text ;
wire Done ;

AES_cipher UUT(CLK , Start , Plain_Text , Key , Cipher_Text , Done) ;


initial begin
		CLK = 0 ; Start = 1;
		   Plain_Text = 128'h3243f6a8885a308d313198a2e0370734;
			Key = 128'h2b7e151628aed2a6abf7158809cf4f3c;

		#10 Plain_Text = 128'h00112233445566778899aabbccddeeff;
			Key=128'h000102030405060708090a0b0c0d0e0f;
			
		#50 $finish;
end

always begin #2 CLK = ~CLK ; end

endmodule