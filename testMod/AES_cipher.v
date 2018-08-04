`include "MixColumns.v"
`include "ShiftRows.v"
`include "SubBytes.v"
`include "AddRoundKey.v"
`include "KeyExpansion.v"
`include "Sbox.v"

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
				AddRoundKey AddRounKeyPipe (pipeLvl[i].first.In_Pipe, pipeLvl[i].first.Round_Key, pipeLvl[i].first.ark_out);
				KeyExpansion KeyExpansionPipe (pipeLvl[i].first.Round_Key, 4'd0, pipeLvl[i].first.nrk_out);
				always @ (posedge clk) begin
					if (!nrst) begin
						pipeLvl[0].first.In_Pipe <= Plain_Text;
						pipeLvl[0].first.Round_Key <= Key;
					end
					else begin
						pipeLvl[0].first.In_Pipe = 128'bxxxx;
						pipeLvl[0].first.Round_Key = 128'bxxxx;
					end
				end
			end
			else if (i == 10) begin : last
				reg [LENGTH-1:0] Round_Key ,  In_Pipe;
				wire  [LENGTH-1:0]  sb_out , sr_out , ark_out , nrk_out;
				SubBytes SubBytesPipe (pipeLvl[i].last.In_Pipe, pipeLvl[i].last.sb_out);
				ShiftRows ShiftRowsPipe (pipeLvl[i].last.sb_out, pipeLvl[i].last.sr_out);
				AddRoundKey AddRounKeyPipe (pipeLvl[i].last.sr_out, pipeLvl[i].last.Round_Key, pipeLvl[i].last.ark_out);
				KeyExpansion KeyExpansionPipe (pipeLvl[i].last.Round_Key, 4'd10, pipeLvl[i].last.nrk_out);
				always@(posedge clk) begin
					if (!nrst) begin
						pipeLvl[i].last.In_Pipe <= pipeLvl[i-1].mid.ark_out;
						pipeLvl[i].last.Round_Key <= pipeLvl[i-1].mid.nrk_out;
						Cipher_Text <= pipeLvl[i].last.ark_out;
					end
					else begin
						pipeLvl[i].last.In_Pipe = 128'bxxxx;
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
				case (i)
					1 : begin
						KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.Round_Key, 4'd1, pipeLvl[i].mid.nrk_out);
					end
					2 : begin
						KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.Round_Key, 4'd2, pipeLvl[i].mid.nrk_out);
					end
					3 : begin
						KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.Round_Key, 4'd3, pipeLvl[i].mid.nrk_out);
					end
					4 : begin
						KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.Round_Key, 4'd4, pipeLvl[i].mid.nrk_out);
					end
					5 : begin
						KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.Round_Key, 4'd5, pipeLvl[i].mid.nrk_out);
					end
					6 : begin
						KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.Round_Key, 4'd6, pipeLvl[i].mid.nrk_out);
					end
					7 : begin
						KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.Round_Key, 4'd7, pipeLvl[i].mid.nrk_out);
					end
					8 : begin
						KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.Round_Key, 4'd8, pipeLvl[i].mid.nrk_out);
					end
					9 : begin
						KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.Round_Key, 4'd9, pipeLvl[i].mid.nrk_out);
					end
				endcase
				always@(posedge clk) begin
					if (!nrst) begin
						if (i == 1) begin
							pipeLvl[1].mid.In_Pipe <= pipeLvl[0].first.ark_out;
							pipeLvl[1].mid.Round_Key <= pipeLvl[0].first.nrk_out;
						end
						else begin
							pipeLvl[i].mid.In_Pipe <= pipeLvl[i-1].mid.ark_out;
							pipeLvl[i].mid.Round_Key <= pipeLvl[i-1].mid.nrk_out;
						end
					end
					else begin
						pipeLvl[i].mid.In_Pipe = 128'bxxxx;
					end
				end
			end
		end
	endgenerate
endmodule
