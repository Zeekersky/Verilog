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

module bit4_BarrelShifter (input [3:0] data, input shift_dir, input shift_amt, output [3:0] data_out);
    // shift_dir = 0 -> Left shift
    // shift_dir = 1 -> Right shift
    // shift_amt = 0 -> 1-bit shift
    // shift_amt = 1 -> 2-bit shift
    Multiplexer_4to1 mux4 ({data[2], data[1], data[2], data[3]}, shift_dir, shift_amt, data_out[0]);
    Multiplexer_4to1 mux5 ({data[3], data[2], data[3], data[0]}, shift_dir, shift_amt, data_out[1]);
    Multiplexer_4to1 mux6 ({data[0], data[3], data[0], data[1]}, shift_dir, shift_amt, data_out[2]);
    Multiplexer_4to1 mux7 ({data[1], data[0], data[1], data[2]}, shift_dir, shift_amt, data_out[3]);
endmodule

module BarrelShifter_TestBench ();
    reg [3:0] data;
    reg shift_dir, shift_amt;
    wire [3:0] data_out;
    bit4_BarrelShifter barrel_shifter (data, shift_dir, shift_amt, data_out);
    initial begin
        $dumpfile("bit4_BarrelShifter.vcd");
        $dumpvars(0, BarrelShifter_TestBench);
        data = 4'b0001; shift_dir = 0; shift_amt = 0;
        #10; data = 4'b0001; shift_dir = 0; shift_amt = 1;
        #10; data = 4'b0001; shift_dir = 1; shift_amt = 0;
        #10; data = 4'b0001; shift_dir = 1; shift_amt = 1;
        #10; $finish;
    end
endmodule