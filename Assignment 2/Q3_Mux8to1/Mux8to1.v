module Mux8to1 (input [7:0] mux_input, input [2:0] select, input enable, output reg mux_output);
    always @ (mux_input, select) begin
        case (select)
            0 : mux_output <= mux_input[0] & enable;
            1 : mux_output <= mux_input[1] & enable;
            2 : mux_output <= mux_input[2] & enable;
            3 : mux_output <= mux_input[3] & enable;
            4 : mux_output <= mux_input[4] & enable;
            5 : mux_output <= mux_input[5] & enable;
            6 : mux_output <= mux_input[6] & enable;
            7 : mux_output <= mux_input[7] & enable;
        endcase
    end
endmodule

module Mux8to1_tb();
    reg [7:0] mux_input;
    reg [2:0] select;
    reg enable;
    wire mux_output;
    Mux8to1 mux8to1 (mux_input, select, enable, mux_output);
    initial begin
        $dumpfile("Mux8to1_tb.vcd");
        $dumpvars(0, Mux8to1_tb);
        mux_input = 8'b00000101; select = 3'b000; enable = 1'b0; #10;
        $display("mux_input = %b, select = %b, enable = %b, mux_output = %b", mux_input, select, enable, mux_output);
        mux_input = 8'b00000001; select = 3'b000; enable = 1'b1; #10;
        $display("mux_input = %b, select = %b, enable = %b, mux_output = %b", mux_input, select, enable, mux_output);
        mux_input = 8'b00000010; select = 3'b001; enable = 1'b1; #10;
        $display("mux_input = %b, select = %b, enable = %b, mux_output = %b", mux_input, select, enable, mux_output);
        mux_input = 8'b00000100; select = 3'b010; enable = 1'b1; #10;
        $display("mux_input = %b, select = %b, enable = %b, mux_output = %b", mux_input, select, enable, mux_output);
        mux_input = 8'b00001000; select = 3'b011; enable = 1'b1; #10;
        $display("mux_input = %b, select = %b, enable = %b, mux_output = %b", mux_input, select, enable, mux_output);
        mux_input = 8'b00010010; select = 3'b100; enable = 1'b1; #10;
        $display("mux_input = %b, select = %b, enable = %b, mux_output = %b", mux_input, select, enable, mux_output);
        mux_input = 8'b00101000; select = 3'b101; enable = 1'b1; #10;
        $display("mux_input = %b, select = %b, enable = %b, mux_output = %b", mux_input, select, enable, mux_output);
        mux_input = 8'b01000000; select = 3'b110; enable = 1'b1; #10;
        $display("mux_input = %b, select = %b, enable = %b, mux_output = %b", mux_input, select, enable, mux_output);
        mux_input = 8'b10011000; select = 3'b111; enable = 1'b1; #10;
        $display("mux_input = %b, select = %b, enable = %b, mux_output = %b", mux_input, select, enable, mux_output);
        $finish;
    end
endmodule

  