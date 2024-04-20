module AND_3bit(input [2:0] a, output y);
    wire w1;
    and gate1(w1, a[0], a[1]);
    and gate2(y, w1, a[2]);
endmodule

module OR_4bit(input [3:0] a, output y);
    wire w1, w2;
    or gate1(w1, a[0], a[1]);
    or gate2(w2, a[2], a[3]);
    or gate3(y, w1, w2);
endmodule

module Multiplexer_4to1 (input [3:0] data, input s1, input s0, output y);
    wire not_s1, not_s0;
    wire [3:0] data_out;
    not gate_not1 (not_s1, s1);
    not gate_not2 (not_s0, s0);
    AND_3bit gate1 ({not_s1, not_s0, data[0]}, data_out[0]);
    AND_3bit gate2 ({not_s1, s0, data[1]}, data_out[1]);
    AND_3bit gate3 ({s1, not_s0, data[2]}, data_out[2]);
    AND_3bit gate4 ({s1, s0, data[3]}, data_out[3]);
    OR_4bit gate5 ({data_out[0], data_out[1], data_out[2], data_out[3]}, y);
endmodule

module Mux_TestBench ();
    reg [3:0] data;
    reg s0, s1;
    wire y;
    Multiplexer_4to1 mux (data, s1, s0, y);
    initial begin
        $dumpfile("Mux_4to1.vcd");
        $dumpvars(0, Mux_TestBench);
        data = 4'b0001; s1 = 0; s0 = 0; #10;
        $display("Data: %b, S1: %b, S0: %b, Y: %b", data, s1, s0, y);
        data = 4'b0010; s1 = 0; s0 = 1; #10; 
        $display("Data: %b, S1: %b, S0: %b, Y: %b", data, s1, s0, y);
        data = 4'b0100; s1 = 1; s0 = 0; #10; 
        $display("Data: %b, S1: %b, S0: %b, Y: %b", data, s1, s0, y);
        data = 4'b1000; s1 = 1; s0 = 1; #10; 
        $display("Data: %b, S1: %b, S0: %b, Y: %b", data, s1, s0, y);
        $finish;
    end
endmodule
    