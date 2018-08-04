`include "MixColumns.v"
`include "ShiftRows.v"
`include "SubBytes.v"
`include "AddRoundKey.v"
`include "KeyExpansion.v"

module AES_cipher # ( parameter BYTE = 8 , parameter DWORD = 32 , parameter LENGTH = 128 )
input clk;
input nrst;
input [LENGTH-1:0] Plain_Text;
input [LENGTH-1:0] Key;
output reg [LENGTH-1:0] Cipher_Text;
	localparam  maxLvl = 11;
	reg [LENGTH-1:0] Round_Key ,  In_Pipe ;   //in pipe is the text in thr pipe
	wire  [LENGTH-1:0]  sb_out , sr_out , mc_out , mux_out , ark_out , nrk_out ;
	wire [3:0] Round_Num ;
	genvar i;
	genrate for (i = 0, i < maxLvl, i = i+1) begin : pipeLvl
		if (i == 0 ) begin
			reg [LENGTH-1:0] Round_Key ,  In_Pipe;
			wire [LENGTH-1:0] ark_out , nrk_out;
			KeyExpansion KeyExpansionPipe (Round_key[i], i, nrk_out[i]);
			always@(posedge clk) begin
				if (!nrst) begin
					In_Pipe[i] = Plain_Text;
					Round_Key[i] = Key
				end
				else begin
					In_pipe = 128'bxxxx
					Round_Key[i] = 128'bxxxx
				end
			end
		end
		else if (i == 10) begin
			reg [LENGTH-1:0] Round_Key ,  In_Pipe ;
			wire  [LENGTH-1:0]  sb_out , sr_out , mc_out , mux_out , ark_out , nrk_out;
			SubBytes SubBytesPipe (In_Pipe][i], sb_out[i]);
			ShiftRows ShiftRowsPipe (sb_out[i], sr_out[i]);
			AddRoundKey AddRounKeyPipe (sr_out[i], Round_Key[i], ark_out[i]);
			KeyExpansion KeyExpansionPipe (Round_key[i], i, nrk_out[i]);
			always@(posedge clk) begin
				if (!nrst) begin
					In_Pipe[i] = ark_out[i-1];
					Round_Key[i] = nrk_out[i-1];
					Cipher_Text = ark_out[i];
				end
				else begin
					In_Pipe[i] = 128'bxxxx
				end
			end
		end
		else begin
			reg [LENGTH-1:0] Round_Key ,  In_Pipe ;
			wire  [LENGTH-1:0]  sb_out , sr_out , mc_out , mux_out , ark_out , nrk_out;
			SubBytes SubBytesPipe (In_Pipe][i], sb_out[i]);
			ShiftRows ShiftRowsPipe (sb_out[i], sr_out[i]);
			MixColumns MixColumnsPipe (sr_out[i], mc_out[i]);
			AddRoundKey AddRounKeyPipe (mc_out[i], Round_Key[i], ark_out[i]);
			KeyExpansion KeyExpansionPipe (Round_key[i], i, nrk_out[i]);
			always@(posedge clk) begin
				if (!nrst) begin
					In_pipe[i] = ark_out[i-1];
					Round_Key[i] = nrk_out[i-1];
				end
				else begin
					In_pipe = 128'bxxxx
				end
			end
		end
	end
endmodule
