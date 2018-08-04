`include "MixColumns.v"
`include "ShiftRows.v"
`include "SubBytes.v"
`include "AddRoundKey.v"
`include "KeyExpansion.v"

module AES_cipher #
(
parameter BYTE = 8,
parameter DWORD = 32,
parameter LENGTH = 128
)
(
input clk,
input nrst,
input [LENGTH-1:0] Plain_Text,
input [LENGTH-1:0] Key,
output reg [LENGTH-1:0] Cipher_Text
);
	localparam maxLvl = 11;
	genvar i;
	generate
		for (i = 0; i < maxLvl; i = i+1) begin : pipeLvl
			if (i == 0 ) begin
				reg [LENGTH-1:0] Round_Key ,  In_Pipe;
				wire [LENGTH-1:0] ark_out , nrk_out;
				KeyExpansion KeyExpansionPipe (pipeLvl[i].Round_key, i, pipeLvl[i].nrk_out);
				always@(posedge clk) begin
					if (!nrst) begin
						pipeLvl[i].In_Pipe = Plain_Text;
						pipeLvl[i].Round_Key = Key;
					end
					else begin
						In_pipe = 128'bxxxx;
						Round_Key[i] = 128'bxxxx;
					end
				end
			end
			else if (i == 10) begin
				reg [LENGTH-1:0] Round_Key ,  In_Pipe ;
				wire  [LENGTH-1:0]  sb_out , sr_out , mc_out , ark_out , nrk_out;
				SubBytes SubBytesPipe (pipeLvl[i].In_Pipe, pipeLvl[i].sb_out);
				ShiftRows ShiftRowsPipe (pipeLvl[i].sb_out, pipeLvl[i].sr_out);
				AddRoundKey AddRounKeyPipe (pipeLvl[i].sr_out, pipeLvl[i].Round_Key, pipeLvl[i].ark_out);
				KeyExpansion KeyExpansionPipe (pipeLvl[i].Round_key, i, pipeLvl[i].nrk_out);
				always@(posedge clk) begin
					if (!nrst) begin
						pipeLvl[i].In_Pipe = pipeLvl[i-1].ark_out;
						pipeLvl[i].Round_Key = pipeLvl[i-1].nrk_out;
						Cipher_Text = pipeLvl[i].ark_out;
					end
					else begin
						In_Pipe[i] = 128'bxxxx;
					end
				end
			end
			else begin
				reg [LENGTH-1:0] Round_Key ,  In_Pipe ;
				wire  [LENGTH-1:0]  sb_out , sr_out , mc_out , mux_out , ark_out , nrk_out;
				SubBytes SubBytesPipe (pipeLvl[i].In_Pipe, pipeLvl[i].sb_out);
				ShiftRows ShiftRowsPipe (pipeLvl[i].sb_out, pipeLvl[i].sr_out);
				MixColumns MixColumnsPipe (pipeLvl[i].sr_out, pipeLvl[i].mc_out);
				AddRoundKey AddRounKeyPipe (pipeLvl[i].mc_out, pipeLvl[i].Round_Key, pipeLvl[i].ark_out);
				KeyExpansion KeyExpansionPipe (Round_key[i], i, nrk_out[i]);
				always@(posedge clk) begin
					if (!nrst) begin
						pipeLvl[i].In_pipe = pipeLvl[i-1].ark_out;
						pipeLvl[i].Round_Key = pipeLvl[i-1].nrk_out;
					end
					else begin
						In_pipe = 128'bxxxx;
					end
				end
			end
		end
	endgenerate
endmodule
