module CONTROLLER(opcode, clk, nrst, out_lights);
    reg [2:0]state, nstate;
    reg rdy;
    reg [1:0] counter;
    reg blink;
    input [2:0] opcode;
    input clk;
    input nrst;
    output reg [5:0]out_lights;
    localparam NO_LIGHTS = 3'b000, TURN_RIGHT = 3'b001, TURN_LEFT = 3'b010, HAZZARD = 3'b011, BRAKE = 3'b100;
    initial begin
        blink = 1'b0;
        counter = 2'b00;
    end
    //reset and nstate progress
    always @ (posedge clk) begin
        if (nrst) begin
            state <= NO_LIGHTS;
        end
        else begin
            state <= nstate;
        end
    end
    //opcode tree
    always @ (posedge clk) begin
        if (!nrst && rdy) begin
            nstate <= opcode;
        end 
    end
    //state machine
    always @ (posedge clk) begin
        case (state)
            NO_LIGHTS : begin
                out_lights = 0;
                rdy = 1;
                nstate = NO_LIGHTS;
            end
            TURN_RIGHT: begin
                if (counter == 2'b00) begin
                    rdy = 0;
                    out_lights = 6'b000100;
                    counter = 2'b01;
                    nstate = TURN_RIGHT;
                end
                else if (counter == 2'b01) begin
                    rdy = 0;
                    out_lights = 6'b000110;
                    counter = 2'b10;
                    nstate = TURN_RIGHT;
                end
                else if (counter == 2'b10) begin
                    rdy = 1'b1;
                    out_lights = 6'b000111;
                    counter = 2'b00;
                    nstate = TURN_RIGHT;
                end
            end
            TURN_LEFT: begin
                if (counter == 2'b00) begin
                    rdy = 0;
                    out_lights = 6'b001000;
                    counter = 2'b01;
                    nstate = TURN_LEFT;
                end
                else if (counter == 2'b01) begin
                    rdy = 0;
                    out_lights = 6'b011000;
                    counter = 2'b10;
                    nstate = TURN_LEFT;
                end
                else if (counter == 2'b10) begin
                    rdy = 1;
                    out_lights = 6'b111000;
                    counter = 2'b00;
                    nstate = TURN_LEFT;
                end
            end            
            HAZZARD: begin
                if (blink == 1'b0) begin
                    blink = 1'b1;
                    out_lights = 6'b000000;
                    nstate = HAZZARD;
                end
                else if (blink == 1'b1) begin
                    blink = 1'b0;
                    out_lights = 6'b111111;
                    nstate = HAZZARD;
                end
            end
            BRAKE: begin
                out_lights = 6'b111111;
            end
        endcase 
    end
endmodule
            
module CONTROLLER_TB();
    reg [2:0] opcode;
    reg clk = 0;
    reg nrst = 1'b1;
    always #1 clk = !clk;
    wire [5:0]out_lights;
    CONTROLLER test_module(.clk(clk), .opcode(opcode), .nrst(nrst), .out_lights(out_lights));
	initial	         
		begin
            $monitor($time, "out_lights=%b, clk=%b, opcode=%b, nrst=%b", out_lights, clk, opcode, nrst);		
            $dumpfile("controller.vcd");
            $dumpvars(0, CONTROLLER_TB);
			#4 nrst=1'b0;
            #4 opcode=3'b000;
            #4 opcode=3'b001;
            #4 opcode=3'b001;
            #4 opcode=3'b010;
            #4 opcode=3'b010;
            #4 opcode=3'b011;
            #4 opcode=3'b011;
            #4 opcode=3'b100;
            #4 opcode=3'b100;
            #4 nrst=1'b1;
            #4 nrst=1'b0;
            #4 opcode=3'b100;
            $finish;
		end
endmodule