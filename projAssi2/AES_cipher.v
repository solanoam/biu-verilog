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
input [LENGTH-1:0] Key,
input [LENGTH-1:0] usrText,
output reg [LENGTH-1:0] encUsrText
);
	localparam maxLvl = 11;
	genvar i;
	generate
		for (i = 0; i < maxLvl; i = i+1) begin : pipeLvl
			if (i == 0) begin : first
				reg [LENGTH-1:0] currRoundKey ,  currPipe;
				wire [LENGTH-1:0] nstate , nkey;
				AddRoundKey AddRounKeyPipe (pipeLvl[i].first.currPipe, pipeLvl[i].first.currRoundKey, pipeLvl[i].first.nstate);
				KeyExpansion KeyExpansionPipe (pipeLvl[i].first.currRoundKey, 4'd0, pipeLvl[i].first.nkey);
				always @ (posedge clk) begin
					if (!nrst) begin
						pipeLvl[0].first.currPipe <= usrText;
						pipeLvl[0].first.currRoundKey <= Key;
					end
					else begin
						pipeLvl[0].first.currPipe = 128'bxxxx;
						pipeLvl[0].first.currRoundKey = 128'bxxxx;
					end
				end
			end
			else if (i == 10) begin : last
				reg [LENGTH-1:0] currRoundKey ,  currPipe;
				wire  [LENGTH-1:0]  sbOut , srOut , nstate , nkey;
				SubBytes SubBytesPipe (pipeLvl[i].last.currPipe, pipeLvl[i].last.sbOut);
				ShiftRows ShiftRowsPipe (pipeLvl[i].last.sbOut, pipeLvl[i].last.srOut);
				AddRoundKey AddRounKeyPipe (pipeLvl[i].last.srOut, pipeLvl[i].last.currRoundKey, pipeLvl[i].last.nstate);
				KeyExpansion KeyExpansionPipe (pipeLvl[i].last.currRoundKey, 4'd10, pipeLvl[i].last.nkey);
				always@(posedge clk) begin
					if (!nrst) begin
						pipeLvl[i].last.currPipe <= pipeLvl[i-1].mid.nstate;
						pipeLvl[i].last.currRoundKey <= pipeLvl[i-1].mid.nkey;
						encUsrText <= pipeLvl[i].last.nstate;
					end
					else begin
						pipeLvl[i].last.currPipe = 128'bxxxx;
					end
				end
			end
			else begin : mid
				reg [LENGTH-1:0] currRoundKey ,  currPipe ;
				wire  [LENGTH-1:0]  sbOut , srOut , mcOut , nstate , nkey;
				SubBytes SubBytesPipe (pipeLvl[i].mid.currPipe, pipeLvl[i].mid.sbOut);
				ShiftRows ShiftRowsPipe (pipeLvl[i].mid.sbOut, pipeLvl[i].mid.srOut);
				MixColumns MixColumnsPipe (pipeLvl[i].mid.srOut, pipeLvl[i].mid.mcOut);
				AddRoundKey AddRounKeyPipe (pipeLvl[i].mid.mcOut, pipeLvl[i].mid.currRoundKey, pipeLvl[i].mid.nstate);
				case (i)
					1 : begin
						KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.currRoundKey, 4'd1, pipeLvl[i].mid.nkey);
					end
					2 : begin
						KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.currRoundKey, 4'd2, pipeLvl[i].mid.nkey);
					end
					3 : begin
						KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.currRoundKey, 4'd3, pipeLvl[i].mid.nkey);
					end
					4 : begin
						KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.currRoundKey, 4'd4, pipeLvl[i].mid.nkey);
					end
					5 : begin
						KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.currRoundKey, 4'd5, pipeLvl[i].mid.nkey);
					end
					6 : begin
						KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.currRoundKey, 4'd6, pipeLvl[i].mid.nkey);
					end
					7 : begin
						KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.currRoundKey, 4'd7, pipeLvl[i].mid.nkey);
					end
					8 : begin
						KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.currRoundKey, 4'd8, pipeLvl[i].mid.nkey);
					end
					9 : begin
						KeyExpansion KeyExpansionPipe (pipeLvl[i].mid.currRoundKey, 4'd9, pipeLvl[i].mid.nkey);
					end
				endcase
				always@(posedge clk) begin
					if (!nrst) begin
						if (i == 1) begin
							pipeLvl[1].mid.currPipe <= pipeLvl[0].first.nstate;
							pipeLvl[1].mid.currRoundKey <= pipeLvl[0].first.nkey;
						end
						else begin
							pipeLvl[i].mid.currPipe <= pipeLvl[i-1].mid.nstate;
							pipeLvl[i].mid.currRoundKey <= pipeLvl[i-1].mid.nkey;
						end
					end
					else begin
						pipeLvl[i].mid.currPipe = 128'bxxxx;
					end
				end
			end
		end
	endgenerate
endmodule
