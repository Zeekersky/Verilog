module half_adder (input a, input b, output sum, output carry);
    xor gate_sum (sum, a, b);
    and gate_carry (carry, a, b);
endmodule

module full_adder (input a, input b, input carry_in, output sum, output carry_out);
    wire w1, w2, w3;
    half_adder ha1 (a, b, w1, w2);
    half_adder ha2 (w1, carry_in, sum, w3);
    or gate_carry_out (carry_out, w2, w3);
endmodule

module half_subtractor (input a, input b, output difference, output borrow);
    wire not_a;
    xor gate_difference (difference, a, b);
    not gate_a (not_a, a);
    and gate_borrow (borrow, not_a, b);
endmodule

module full_subtractor (input a, input b, input borrow_in, output difference, output borrow_out);
    wire w1, w2, w3;
    half_subtractor hs1 (a, b, w1, w2);
    half_subtractor hs2 (w1, borrow_in, difference, w3);
    or gate_borrow_out (borrow_out, w2, w3);
endmodule

module Adder_Subtractor_TestBench ();
    reg HA1, HA2, FA1, FA2, FA_CARRY_IN, HS1, HS2, FS1, FS2, FS_BORROW_IN;
    wire HA_SUM, HA_CARRY, FA_SUM, FA_CARRY_OUT, HS_DIFF, HS_BORROW, FS_DIFF, FS_BORROW_OUT;
    half_adder ha (HA1, HA2, HA_SUM, HA_CARRY);
    full_adder fa (FA1, FA2, FA_CARRY_IN, FA_SUM, FA_CARRY_OUT);
    half_subtractor hs (HS1, HS2, HS_DIFF, HS_BORROW);
    full_subtractor fs (FS1, FS2, FS_BORROW_IN, FS_DIFF, FS_BORROW_OUT);
    initial begin
        $dumpfile("adder_subtractor_test.vcd");
        $dumpvars(0, Adder_Subtractor_TestBench);

        HA1 = 0; HA2 = 0;
        #10 HA1 = 0; HA2 = 1;
        #10 HA1 = 1; HA2 = 0;
        #10 HA1 = 1; HA2 = 1;

        #20 FA1 = 0; FA2 = 0; FA_CARRY_IN = 0;
        #10 FA1 = 0; FA2 = 1; FA_CARRY_IN = 0;
        #10 FA1 = 1; FA2 = 0; FA_CARRY_IN = 0;
        #10 FA1 = 1; FA2 = 1; FA_CARRY_IN = 0;
        #10 FA1 = 0; FA2 = 0; FA_CARRY_IN = 1;
        #10 FA1 = 0; FA2 = 1; FA_CARRY_IN = 1;
        #10 FA1 = 1; FA2 = 0; FA_CARRY_IN = 1;
        #10 FA1 = 1; FA2 = 1; FA_CARRY_IN = 1;

        #20 HS1 = 0; HS2 = 0;
        #10 HS1 = 0; HS2 = 1;
        #10 HS1 = 1; HS2 = 0;
        #10 HS1 = 1; HS2 = 1;

        #20 FS1 = 0; FS2 = 0; FS_BORROW_IN = 0;
        #10 FS1 = 0; FS2 = 1; FS_BORROW_IN = 0;
        #10 FS1 = 1; FS2 = 0; FS_BORROW_IN = 0;
        #10 FS1 = 1; FS2 = 1; FS_BORROW_IN = 0;
        #10 FS1 = 0; FS2 = 0; FS_BORROW_IN = 1;
        #10 FS1 = 0; FS2 = 1; FS_BORROW_IN = 1;
        #10 FS1 = 1; FS2 = 0; FS_BORROW_IN = 1;
        #10 FS1 = 1; FS2 = 1; FS_BORROW_IN = 1;
        #10 $finish;
    end
endmodule


