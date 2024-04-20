module AND_4bit(input [3:0] a, output y);
    wire w1, w2;
    and gate1(w1, a[0], a[1]);
    and gate2(w2, a[2], a[3]);
    and gate3(y, w1, w2);
endmodule

module OR_4bit(input [3:0] a, output y);
    wire w1, w2;
    or gate1(w1, a[0], a[1]);
    or gate2(w2, a[2], a[3]);
    or gate3(y, w1, w2);
endmodule

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

module Multiplexer_8to1 (input [7:0] data, input s2, input s1, input s0, output y);
    wire not_s2, not_s1, not_s0, or_1, or_0;
    wire [7:0] data_out;
    not gate_not1 (not_s1, s1);
    not gate_not2 (not_s0, s0);
    not gate_not3 (not_s2, s2);

    AND_4bit gate1 ({not_s2, not_s1, not_s0, data[0]}, data_out[0]);
    AND_4bit gate2 ({not_s2, not_s1, s0, data[1]}, data_out[1]);
    AND_4bit gate3 ({not_s2, s1, not_s0, data[2]}, data_out[2]);
    AND_4bit gate4 ({not_s2, s1, s0, data[3]}, data_out[3]);
    AND_4bit gate5 ({s2, not_s1, not_s0, data[4]}, data_out[4]);
    AND_4bit gate6 ({s2, not_s1, s0, data[5]}, data_out[5]);
    AND_4bit gate7 ({s2, s1, not_s0, data[6]}, data_out[6]);
    AND_4bit gate8 ({s2, s1, s0, data[7]}, data_out[7]);

    OR_4bit gate9 ({data_out[0], data_out[1], data_out[2], data_out[3]}, or_0);
    OR_4bit gate10 ({data_out[4], data_out[5], data_out[6], data_out[7]}, or_1);
    or gate11 (y, or_0, or_1);

endmodule

module Addition_4bit (input [3:0] A, input [3:0] B, output [7:0] S);
    wire w1, w2, w3;
    full_adder fa1 (A[0], B[0], 1'b0, S[0], w1);
    full_adder fa2 (A[1], B[1], w1, S[1], w2);
    full_adder fa3 (A[2], B[2], w2, S[2], w3);
    full_adder fa4 (A[3], B[3], w3, S[3], S[4]);

    xor gate1 (S[5], 0, 0);
    xor gate2 (S[6], 0, 0);
    xor gate3 (S[7], 0, 0);
endmodule

module Subtraction_4bit (input [3:0] A, input [3:0] B, output [7:0] S);
    wire w1, w2, w3, borrow;

    // 2's complement of B
    wire [3:0] not_B;
    not gate1_not_B (not_B[0], B[0]);
    not gate2_not_B (not_B[1], B[1]);
    not gate3_not_B (not_B[2], B[2]);
    not gate4_not_B (not_B[3], B[3]);

    // Subtraction using 2's complement
    full_adder fa1 (A[0], not_B[0], 1'b1, S[0], w1);
    full_adder fa2 (A[1], not_B[1], w1, S[1], w2);
    full_adder fa3 (A[2], not_B[2], w2, S[2], w3);
    full_adder fa4 (A[3], not_B[3], w3, S[3], borrow);

    // Handling Borrow - Negetive values are shown as 2's complement and Positive values are shown as it is. Sign bit is S[4]
    // S[7:5] are sign extension.
    wire not_S4, case_ignore, case_2s_complement;
    not gate_not_S4 (not_S4, borrow);
    and gate_case_ignore (case_ignore, borrow, 1'b0);
    and gate_case_2s_complement (case_2s_complement, not_S4, 1'b1);
    or gate_borrow (S[4], case_ignore, case_2s_complement);

    xor gate1 (S[5], 0, S[4]);
    xor gate2 (S[6], 0, S[4]);
    xor gate3 (S[7], 0, S[4]);
endmodule

module Multiplication_4bit (input [3:0] A, input [3:0] B, output [7:0] S);
    wire P0, P1, P2, P3, Q0, Q1, Q2;
    wire [7:0] I1;

    and gate_out0 (S[0], A[0], B[0]); // S0 = A0.B0
    and gate2 (Q0, A[1], B[0]);
    and gate3 (Q1, A[2], B[0]);
    and gate4 (Q2, A[3], B[0]);

    and gate5 (P0, A[0], B[1]);
    and gate6 (P1, A[1], B[1]);
    and gate7 (P2, A[2], B[1]);
    and gate8 (P3, A[3], B[1]);

    Addition_4bit adder1 ({P3, P2, P1, P0}, {1'b0, Q2, Q1, Q0}, I1);
    xor gate_out1 (S[1], I1[0], 0); // S1 = I1[0]

    wire M0, M1, M2, M3;
    wire [7:0] I2;
    and gate9 (M0, A[0], B[2]);
    and gate10 (M1, A[1], B[2]);
    and gate11 (M2, A[2], B[2]);
    and gate12 (M3, A[3], B[2]);

    Addition_4bit adder2 ({I1[4], I1[3], I1[2], I1[1]}, {M3, M2, M1, M0}, I2);
    xor gate_out2 (S[2], I2[0], 0); // S2 = I2[0]

    wire N0, N1, N2, N3;
    wire [7:0] I3;
    and gate13 (N0, A[0], B[3]);
    and gate14 (N1, A[1], B[3]);
    and gate15 (N2, A[2], B[3]);
    and gate16 (N3, A[3], B[3]);

    Addition_4bit adder3 ({I2[4], I2[3], I2[2], I2[1]}, {N3, N2, N1, N0}, I3);
    xor gate_out3 (S[3], I3[0], 0); // S3 = I3[0]
    xor gate_out4 (S[4], I3[1], 0); // S4 = I3[1]
    xor gate_out5 (S[5], I3[2], 0); // S5 = I3[2]
    xor gate_out6 (S[6], I3[3], 0); // S6 = I3[3]
    xor gate_out7 (S[7], I3[4], 0); // S7 = I3[4]
endmodule

module logical_AND (input [3:0] A, input [3:0] B, output [7:0] S);
    and gate1 (S[0], A[0], B[0]);
    and gate2 (S[1], A[1], B[1]);
    and gate3 (S[2], A[2], B[2]);
    and gate4 (S[3], A[3], B[3]);

    xor gate5 (S[4], 0, 0);
    xor gate6 (S[5], 0, 0);
    xor gate7 (S[6], 0, 0);
    xor gate8 (S[7], 0, 0);
endmodule

module logical_OR (input [3:0] A, input [3:0] B, output [7:0] S);
    or gate1 (S[0], A[0], B[0]);
    or gate2 (S[1], A[1], B[1]);
    or gate3 (S[2], A[2], B[2]);
    or gate4 (S[3], A[3], B[3]);

    xor gate5 (S[4], 0, 0);
    xor gate6 (S[5], 0, 0);
    xor gate7 (S[6], 0, 0);
    xor gate8 (S[7], 0, 0);
endmodule

module logical_XOR (input [3:0] A, input [3:0] B, output [7:0] S);
    xor gate1 (S[0], A[0], B[0]);
    xor gate2 (S[1], A[1], B[1]);
    xor gate3 (S[2], A[2], B[2]);
    xor gate4 (S[3], A[3], B[3]);

    xor gate5 (S[4], 0, 0);
    xor gate6 (S[5], 0, 0);
    xor gate7 (S[6], 0, 0);
    xor gate8 (S[7], 0, 0);
endmodule

module simple_bit_ALU (input [3:0] A, input [3:0] B, input [2:0] control, output [7:0] out);
    wire w1;
    wire [7:0] Sum, Difference, Product, AND, OR, XOR;

    Addition_4bit adder (A, B, Sum);
    Subtraction_4bit subtractor (A, B, Difference);
    Multiplication_4bit multiplier (A, B, Product);
    logical_AND and_gate (A, B, AND);
    logical_OR or_gate (A, B, OR);
    logical_XOR xor_gate (A, B, XOR);

    // OPCODE:
    // 000 -> Addition, 001 -> Subtraction, 010 -> Multiplication, 011 -> AND, 100 -> OR, 101 -> XOR, 110 -> No Output, 111 -> SNo Output
    Multiplexer_8to1 mux1 ({1'b0, 1'b0, XOR[0], OR[0], AND[0], Product[0], Difference[0], Sum[0]}, control[2], control[1], control[0], out[0]);
    Multiplexer_8to1 mux2 ({1'b0, 1'b0, XOR[1], OR[1], AND[1], Product[1], Difference[1], Sum[1]}, control[2], control[1], control[0], out[1]);
    Multiplexer_8to1 mux3 ({1'b0, 1'b0, XOR[2], OR[2], AND[2], Product[2], Difference[2], Sum[2]}, control[2], control[1], control[0], out[2]);
    Multiplexer_8to1 mux4 ({1'b0, 1'b0, XOR[3], OR[3], AND[3], Product[3], Difference[3], Sum[3]}, control[2], control[1], control[0], out[3]);
    Multiplexer_8to1 mux5 ({1'b0, 1'b0, XOR[4], OR[4], AND[4], Product[4], Difference[4], Sum[4]}, control[2], control[1], control[0], out[4]);
    Multiplexer_8to1 mux6 ({1'b0, 1'b0, XOR[5], OR[5], AND[5], Product[5], Difference[5], Sum[5]}, control[2], control[1], control[0], out[5]);
    Multiplexer_8to1 mux7 ({1'b0, 1'b0, XOR[6], OR[6], AND[6], Product[6], Difference[6], Sum[6]}, control[2], control[1], control[0], out[6]);
    Multiplexer_8to1 mux8 ({1'b0, 1'b0, XOR[7], OR[7], AND[7], Product[7], Difference[7], Sum[7]}, control[2], control[1], control[0], out[7]);
endmodule

module simple_bit_ALU_TestBench ();
    reg [3:0] A, B;
    reg [2:0] control;
    // wire [7:0] Sum, Difference, Product, AND, OR, XOR;
    wire [7:0] out;

    // Addition_4bit adder (A, B, Sum);
    // Subtraction_4bit subtractor (A, B, Difference); 
    // Multiplication_4bit multiplier (A, B, Product);
    // logical_AND and_gate (A, B, AND);
    // logical_OR or_gate (A, B, OR);
    // logical_XOR xor_gate (A, B, XOR); 

    simple_bit_ALU simple_ALU (A, B, control, out);

    initial begin
        $dumpfile("simple-bit_ALU.vcd");
        $dumpvars(0, simple_bit_ALU_TestBench);
        A = 4'b1111; B = 4'b1111; control = 3'b000;
        #10 A = 4'b0010; B = 4'b0011; control = 3'b001;
        #10 A = 4'b1010; B = 4'b1101; control = 3'b001;
        #10 A = 4'b1111; B = 4'b1111; control = 3'b010;
        #10 A = 4'b1011; B = 4'b1101; control = 3'b011;
        #10 A = 4'b1011; B = 4'b1101; control = 3'b100;
        #10 A = 4'b1010; B = 4'b1100; control = 3'b101;
        #10 A = 4'b1010; B = 4'b1100; control = 3'b110;
        #10 $finish;
    end
endmodule