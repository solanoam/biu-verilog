module ICE_BAR(coin, clk, nrst, rls, change, state, nstate);
    output reg [2:0] state, nstate;
    input [1:0] coin;
    input clk;
    input nrst;
    output reg [2:0] change;
    output reg rls;
    localparam NOTHING = 2'b00, NIS_2 = 2'b10, NIS_5 = 2'b01;
    localparam ZERO = 3'b000, ONE = 3'b001, TWO = 3'b010, THREE = 3'b011, FOUR = 3'b100, FIVE = 3'b101; 
    //reset and nstate progress
    always @ (posedge clk) begin
        if (nrst) begin
            state = ZERO;
        end
        else begin
            state = nstate;
        end
    end
    //state machine
    always @ (posedge clk) begin
        case (state)
            ZERO : begin  
                if (coin == NOTHING) begin
                    nstate = ZERO;
                    rls = 0;
                    change = 0;            
                end
                if (coin == NIS_2) begin
                    nstate = ONE;
                    rls = 0;
                    change = 0;
                end             
                if (coin == NIS_5) begin
                    nstate = TWO;
                    rls = 0;
                    change = 0;
                end
            end
             ONE : begin  
                if (coin == NOTHING) begin
                    nstate = ONE;
                    rls = 0;
                    change = 0;            
                end
                if (coin == NIS_2) begin
                    nstate = THREE;
                    rls = 0;
                    change = 0;
                end             
                if (coin == NIS_5) begin
                    nstate = FIVE;
                    rls = 0;
                    change = 0;
                end
             end
             TWO : begin  
                if (coin == NOTHING) begin
                    nstate = TWO;
                    rls = 0;
                    change = 0;            
                end
                if (coin == NIS_2) begin
                    nstate = FIVE;
                    rls = 0;
                    change = 0;
                end             
                if (coin == NIS_5) begin
                    nstate = ZERO;
                    rls = 1;
                    change = 3'b010;
                end
             end
             THREE : begin  
                if (coin == NOTHING) begin
                    nstate = THREE;
                    rls = 0;
                    change = 0;            
                end
                if (coin == NIS_2) begin
                    nstate = FOUR;
                    rls = 0;
                    change = 0;
                end             
                
                if (coin == NIS_5) begin
                    nstate = ZERO;
                    rls = 1;
                    change = 3'b001;
                end
             end
             FOUR : begin  
                
                if (coin == NOTHING) begin
                    nstate = FOUR;
                    rls = 0;
                    change = 0;            
                end
                
                if (coin == NIS_2) begin
                    nstate = ZERO;
                    rls = 1;
                    change = 0;
                end             
                
                if (coin == NIS_5) begin
                    nstate = ZERO;
                    rls = 0;
                    change = 3'b011;
                end
             end
             FIVE : begin  
                
                if (coin == NOTHING) begin
                    nstate = ZERO;
                    rls = 0;
                    change = 0;            
                end
                
                if (coin == NIS_2) begin
                    nstate = ZERO;
                    rls = 1;
                    change = 3'b001;
                end             
                
                if (coin == NIS_5) begin
                    nstate = ZERO;
                    rls = 1;
                    change = 3'b100;
                end
             end
        endcase 
    end
endmodule
            
module ICE_BAR_TB();
    reg [1:0] coin;
    reg clk = 0;
    reg nrst = 1'b1;
    wire [2:0] state, nstate;
    always #1 clk = !clk;
    wire rls;
    wire [2:0]change;
    ICE_BAR test_module(.clk(clk), .coin(coin), .nrst(nrst), .rls(rls), .change(change), .state(state), .nstate(nstate));
	initial	         
		begin
            $monitor($time, "rls=%b, change=%b, state=%b, nstate=%b, clk=%b, coin=%b, nrst=%b", rls, change, state, nstate, clk, coin, nrst);		
            $dumpfile("ice_bar.vcd");
            $dumpvars(0, ICE_BAR_TB);
            #4 coin=2'b00;
            #8 nrst=1'b1;
            #4 nrst=1'b0;
            
            #4 coin=2'b01;
            #4 coin=2'b01;
            
            #4 coin=2'b10;
            #4 coin=2'b10;
            #4 coin=2'b10;
            #4 coin=2'b10;
            
            #4 coin=2'b10;
            #4 coin=2'b10;
            #4 coin=2'b10;
            #4 coin=2'b01;
            
            #4 coin=2'b01;
            #4 coin=2'b01;
            
            #4 coin=2'b01;
            #4 coin=2'b10;
            #4 coin=2'b10;
            #4 coin=2'b00;
            
            #4 coin=2'b01;
            #4 coin=2'b01;
            
            #4 coin=2'b10;
            #4 coin=2'b10;
            #4 coin=2'b10;
            #4 coin=2'b10;
            
            #4 coin=2'b10;
            #4 coin=2'b10;
            #4 coin=2'b10;
            #4 coin=2'b01;
            $finish;
		end
endmodule