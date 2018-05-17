module ALU(in1, in2, alu_op, res);
    input signed [31:0]in1;
    input signed [31:0]in2;
    input [2:0]alu_op;
    output [31:0]res;
    parameter ADD = 3'b000;
    parameter SUB = 3'b001;
    parameter ADDI = 3'b010;
    parameter OR = 3'b011;
    parameter ORI = 3'b100;
    parameter SLL = 3'b101;
    parameter SRL = 3'b110;
    parameter SRA = 3'b111;
    assign res = (alu_op == ADD) ? (in1+in2) :
        (alu_op == SUB) ? (in1-in2) :
        (alu_op == ADDI) ? (in1+in2) :
        (alu_op == OR) ? ($unsigned(in1)|$unsigned(in2)) :
        (alu_op == ORI) ? ($unsigned(in1)|$unsigned(in2)) :
        (alu_op == SLL) ? ($unsigned(in1) << $unsigned(in2)) :
        (alu_op == SRL) ? ($unsigned(in1) >> $unsigned(in2)) :
        (alu_op == SRA) ? ($unsigned(in1) >>> $unsigned(in2)) : 32'b0;
endmodule  

module ALU_TB ();  
    reg signed [31:0]in1;
    reg signed [31:0]in2;
    reg [2:0]alu_op;
    wire [31:0]res;
    parameter ADD = 3'b000;
    parameter SUB = 3'b001;
    parameter ADDI = 3'b010;
    parameter OR = 3'b011;
    parameter ORI = 3'b100;
    parameter SLL = 3'b101;
    parameter SRL = 3'b110;
    parameter SRA = 3'b111;
    ALU ALU_TEST (.in1(in1), .in2(in2), .alu_op(alu_op), .res(res));
    initial begin 
        $monitor($time,"in1=%b, in2=%b, alu_op=%b, res=%b", in1, in2, alu_op, res);
        $dumpfile("test.vcd");
        $dumpvars(0, ALU_TB);
        #1 in1 = 32'b11 ; in2 = 32'b101; alu_op = ADD;
        #2 in1 = 32'b11 ; in2 = 32'b101; alu_op = ADDI;
        #3 in1 = 32'b11 ; in2 = 32'b101; alu_op = SUB;
        #4 in1 = 32'b11 ; in2 = 32'b101; alu_op = OR;
        #5 in1 = 32'b11 ; in2 = 32'b101; alu_op = ORI;
        #6 in1 = 32'b11 ; in2 = 32'b101; alu_op = SLL;
        #7 in1 = 32'b11 ; in2 = 32'b001; alu_op = SRL;
        #8 in1 = 32'b11 ; in1[31] = 1'b1; in2 = 32'b001; alu_op = SRA;
        #9 in1 = 32'b11 ; in1[31] = 1'b1; in2 = 32'b101; alu_op = ADD; 
    end 
endmodule