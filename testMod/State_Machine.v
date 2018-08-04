module State_Machine # ( parameter BYTE = 8 , parameter WORD = 32 , parameter SENTENCE = 128 )
( input CLK , input Start , output reg Done ,output reg [3:0] Round_Num ) ;
localparam round_0 = 4'd0 , round_1 = 4'd1 , round_2 = 4'd2 , round_3 = 4'd3 , round_4 = 4'd4 , round_5 = 4'd5 ,
 round_6 = 4'd6 , round_7 = 4'd7 , round_8 = 4'd8 , round_9 = 4'd9 ,  round_10 = 4'd10 ;

 // initiate the state machine with the beginning - round 0  
initial begin  
	Round_Num = round_0 ; 
end
 
always @ ( posedge CLK or negedge Start  ) begin
	if ( !Start ) begin // like nrst - reset the state machine
		Round_Num = round_0 ; 
	end else
	case ( Round_Num ) // switch case for the next state
		round_0 : begin Round_Num = round_1 ; Done = 0 ; end
		
		round_1 : begin Round_Num = round_2 ; end
		round_2 : begin Round_Num = round_3 ; end
		round_3 : begin Round_Num = round_4 ; end
		round_4 : begin Round_Num = round_5 ; end
		round_5 : begin Round_Num = round_6 ; end
		round_6 : begin Round_Num = round_7 ; end
		round_7 : begin Round_Num = round_8 ; end
		round_8 : begin Round_Num = round_9 ; end
		round_9 : begin Round_Num = round_10 ; end
		
		round_10 : begin
		Round_Num = round_0 ; // after 10 round go to beginning
		Done = 1 ;	// output done to 1 for the cipher text to output  
		end
		
		default : Round_Num = round_0 ;
		
	endcase
 end
endmodule