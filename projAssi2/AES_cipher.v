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
			if (i == 0) begin : first
				reg [LENGTH-1:0] Round_Key ,  In_Pipe;
				wire [LENGTH-1:0] ark_out , nrk_out;
				KeyExpansion KeyExpansionPipe (pipeLvl[i].first.Round_Key, i, pipeLvl[i].first.nrk_out);
				always @ (posedge clk) begin
					if (!nrst) begin
						pipeLvl[i].first.In_Pipe <= Plain_Text;
						pipeLvl[i].first.Round_Key <= Key;
					end
					else begin
						pipeLvl[i].first.In_Pipe <= 128'b00000;
						pipeLvl[i].first.Round_Key <= 128'b0000;
					end
				end
			end
			else if (i == 10) begin : last
				reg [LENGTH-1:0] Round_Key ,  In_Pipe ;
				wire  [LENGTH-1:0]  sb_out , sr_out , mc_out , ark_out , nrk_out;
				SubBytes SubBytesPipe (pipeLvl[i].last.In_Pipe, pipeLvl[i].last.sb_out);
				ShiftRows ShiftRowsPipe (pipeLvl[i].last.sb_out, pipeLvl[i].last.sr_out);
				AddRoundKey AddRounKeyPipe (pipeLvl[i].last.sr_out, pipeLvl[i].last.Round_Key, pipeLvl[i].last.ark_out);
				KeyExpansion KeyExpansionPipe (pipeLvl[i].last.Round_Key, i, pipeLvl[i].last.nrk_out);
				always@(posedge clk) begin
					if (!nrst) begin
						pipeLvl[i].last.In_Pipe <= pipeLvl[i-1].mid.ark_out;
						pipeLvl[i].last.Round_Key <= pipeLvl[i-1].mid.nrk_out;
						Cipher_Text <= pipeLvl[i].last.ark_out;
					end
					else begin
						pipeLvl[i].last.In_Pipe <= 128'b000;
					end
				end
			end
			else begin : mid
				reg [LENGTH-1:0] Round_Key ,  In_Pipe ;
				wire  [LENGTH-1:0]  sb_out , sr_out , mc_out , ark_out , nrk_out;
				SubBytes SubBytesPipe (pipeLvl[i].mid.In_Pipe, pipeLvl[i].mid.sb_out);
				ShiftRows ShiftRowsPipe (pipeLvl[i].mid.sb_out, pipeLvl[i].mid.sr_out);
				MixColumns MixColumnsPipe (pipeLvl[i].mid.sr_out, pipeLvl[i].mid.mc_out);
				AddRoundKey AddRounKeyPipe (pipeLvl[i].mid.mc_out, pipeLvl[i].mid.Round_Key, pipeLvl[i].mid.ark_out);
				KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.Round_Key, i, pipeLvl[i].mid.nrk_out);
				always@(posedge clk) begin
					if (!nrst) begin
						if (i == 1) begin
							pipeLvl[i].mid.In_Pipe <= pipeLvl[i-1].first.ark_out;
							pipeLvl[i].mid.Round_Key <= pipeLvl[i-1].first.nrk_out;
						end
						else begin
							pipeLvl[i].mid.In_Pipe <= pipeLvl[i-1].mid.ark_out;
							pipeLvl[i].mid.Round_Key <= pipeLvl[i-1].mid.nrk_out;
						end
					end
					else begin
						pipeLvl[i].mid.In_Pipe <= 128'b0000;
					end
				end
			end
		end
	endgenerate
endmodule
