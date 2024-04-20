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

module AND_3bit(input [2:0] a, output y);
    
    wire w1;
    and gate1(w1, a[0], a[1]);
    and gate2(y, w1, a[2]);

endmodule

module bit4_Comparator (input [3:0] a, input [3:0] b, output eq, output lt, output gt);

    // Check if Equal
    wire [3:0] w_eq;
    xnor gate1_eq(w_eq[0], a[0], b[0]);
    xnor gate2_eq(w_eq[1], a[1], b[1]);
    xnor gate3_eq(w_eq[2], a[2], b[2]);
    xnor gate4_eq(w_eq[3], a[3], b[3]);
    AND_4bit eq_gate(w_eq, eq);

    // Not Conversion
    wire [3:0] w_not_a;
    wire [3:0] w_not_b;
    not gate1_not_a(w_not_a[0], a[0]);
    not gate2_not_a(w_not_a[1], a[1]);
    not gate3_not_a(w_not_a[2], a[2]);
    not gate4_not_a(w_not_a[3], a[3]);
    not gate1_not_b(w_not_b[0], b[0]);
    not gate2_not_b(w_not_b[1], b[1]);
    not gate3_not_b(w_not_b[2], b[2]);
    not gate4_not_b(w_not_b[3], b[3]);

    // Check if Less Than
    wire [3:0] w_lt;
    and lt_gate1(w_lt[0], w_not_a[0], b[0]);
    and lt_gate2(w_lt[1], w_not_a[1], b[1]);
    and lt_gate3(w_lt[2], w_not_a[2], b[2]);
    and lt_gate4(w_lt[3], w_not_a[3], b[3]);

    wire [2:0] w_lt_eq;
    AND_4bit lt_eq_gate1({w_eq[3], w_eq[2], w_eq[1], w_lt[0]}, w_lt_eq[0]);
    AND_3bit lt_eq_gate2({w_eq[3], w_eq[2], w_lt[1]}, w_lt_eq[1]);
    and lt_eq_gate3(w_lt_eq[2], w_eq[3], w_lt[2]);

    OR_4bit lt_eq_gate4({w_lt[3],w_lt_eq[2],w_lt_eq[1],w_lt_eq[0]}, lt);

    // Check if Greater Than
    wire [3:0] w_gt;
    and gt_gate1(w_gt[0], a[0], w_not_b[0]);
    and gt_gate2(w_gt[1], a[1], w_not_b[1]);
    and gt_gate3(w_gt[2], a[2], w_not_b[2]);
    and gt_gate4(w_gt[3], a[3], w_not_b[3]);

    wire [2:0] w_gt_eq;
    AND_4bit gt_eq_gate1({w_eq[3], w_eq[2], w_eq[1], w_gt[0]}, w_gt_eq[0]);
    AND_3bit gt_eq_gate2({w_eq[3], w_eq[2], w_gt[1]}, w_gt_eq[1]);
    and gt_eq_gate3(w_gt_eq[2], w_eq[3], w_gt[2]);

    OR_4bit gt_eq_gate4({w_gt[3],w_gt_eq[2],w_gt_eq[1],w_gt_eq[0]}, gt);

endmodule  

module bit4_Comparator_TestBench();

    reg [3:0] A;
    reg [3:0] B;
    wire eq, lt, gt;

    bit4_Comparator gate1 (A, B, eq, lt, gt);

    initial begin

        $dumpfile("bit4_Comparator.vcd");
        $dumpvars(0, bit4_Comparator_TestBench);

        A = 8; B = 8;
        #10 A = 8; B = 7;
        #10 A = 8; B = 9;
        #10 A = 12; B = 4;
        #10 A = 4; B = 12;
        #10 $finish;
        
    end

endmodule