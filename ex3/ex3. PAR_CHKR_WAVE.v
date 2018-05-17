module PAR_CHKR(data_in, ,clk, rst, data_out, c_flag);
    input [35:0]data_in;
    input clk;
    input rst;
    reg [31:0] data_out_tmp;
    output [31:0]data_out;
    reg c_flag_tmp;
    output c_flag;
    reg xor_res[3:0];
    reg [3:0] p_byte;
    always @ (posedge clk) begin
        if (!rst) begin
            p_byte[0] = ^data_in[7:0];
            p_byte[1] = ^data_in[15:8];
            p_byte[2] = ^data_in[23:16];
            p_byte[3] = ^data_in[31:24];
            xor_res[0] = p_byte[0]^data_in[32];
            xor_res[1] = p_byte[1]^data_in[33];
            xor_res[2] = p_byte[2]^data_in[34];
            xor_res[3] = p_byte[3]^data_in[35];
            if (xor_res[0] || xor_res[1] || xor_res[2] || xor_res[3]) begin
                c_flag_tmp = 1'b1;
                data_out_tmp = 32'bx;
            end
            else begin 
                c_flag_tmp = 1'b0;
                data_out_tmp = data_in;
            end
        end
        else begin
            c_flag_tmp = 1'b0;
            data_out_tmp = 32'b0;
        end
    end
    assign c_flag = c_flag_tmp;
    assign data_out = data_out_tmp;
endmodule

module PAR_CHKR_TB ();
    reg [35:0]data_in;
    reg clk;
    reg rst;
    wire [31:0]data_out;
    wire c_flag;
    always #1 clk = !clk;
    PAR_CHKR PAR_CHKR_TEST (.data_in(data_in), .clk(clk), .rst(rst), .data_out(data_out), .c_flag(c_flag));
    initial begin 
        $monitor($time,"data_in=%b, clk=%b, rst=%b, data_out=%b, c_flag=%b", data_in, clk, rst, data_out, c_flag);
        $dumpfile("test_par_chkr.vcd");
        $dumpvars(0, PAR_CHKR_TB);
        #0 clk = 1'b0;
        #2 data_in = 36'b0; rst = 1'b0; //no flag
        #3 data_in = 36'b1; rst = 1'b0; //flag
        #4 data_in = 36'b1; data_in[32] = 1'b1;  rst = 1'b0; //no flag 
        #5 data_in = 36'b1111111; rst = 1'b1;  //reset
    end 
endmodule