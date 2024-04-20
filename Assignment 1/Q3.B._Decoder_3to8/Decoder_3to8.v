module Decoder_3to8 (input s2, input s1, input s0, output [7:0] y);
    wire not_s2, not_s1, not_s0;
    not gate_not1 (not_s1, s1);
    not gate_not2 (not_s0, s0);
    not gate_not3 (not_s2, s2);
    and gate1 (y[0], not_s2, not_s1, not_s0);
    and gate2 (y[1], not_s2, not_s1, s0);
    and gate3 (y[2], not_s2, s1, not_s0);
    and gate4 (y[3], not_s2, s1, s0);
    and gate5 (y[4], s2, not_s1, not_s0);
    and gate6 (y[5], s2, not_s1, s0);
    and gate7 (y[6], s2, s1, not_s0);
    and gate8 (y[7], s2, s1, s0);
endmodule

module DEC_TestBench();
    reg s2, s1, s0;
    wire [7:0] y;
    Decoder_3to8 dec (s2, s1, s0, y);
    initial begin
        $dumpfile("Decoder_3to8.vcd");
        $dumpvars(0, DEC_TestBench);
        s2 = 0; s1 = 0; s0 = 0;
        #10; s2 = 0; s1 = 0; s0 = 1;
        #10; s2 = 0; s1 = 1; s0 = 0;
        #10; s2 = 0; s1 = 1; s0 = 1;
        #10; s2 = 1; s1 = 0; s0 = 0;
        #10; s2 = 1; s1 = 0; s0 = 1;
        #10; s2 = 1; s1 = 1; s0 = 0;
        #10; s2 = 1; s1 = 1; s0 = 1;
        #10; $finish;
    end
endmodule