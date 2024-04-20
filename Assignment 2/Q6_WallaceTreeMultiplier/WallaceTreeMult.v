module HalfAdder(input A, input B, output SUM, output CARRY);
    assign SUM = A ^ B;
    assign CARRY = A & B;
endmodule

module FullAdder(input A, input B, input CIN, output SUM, output COUT);
    wire carry1, carry2, SUM_TMP;
    HalfAdder HA1(A, B, SUM_TMP, carry1);
    HalfAdder HA2(SUM_TMP, CIN, SUM, carry2);
    assign COUT = carry1 | carry2;
endmodule

module WallaceTreeMult(input [3:0] inp_P, input [3:0] inp_Q, output [7:0] Mult);
    
    reg MULT_TEMP[3:0][3:0];

    wire [3:0] SUM_TEMP1, SUM_TEMP2, SUM_TEMP3;
    wire CarryTMP11, CarryTMP12, CarryTMP13, CarryTMP14;
    wire CarryTMP21, CarryTMP22, CarryTMP23, CarryTMP24;
    wire CarryTMP31, CarryTMP32, CarryTMP33, CarryTMP34;
    integer i, j;
    
    always @ (inp_P or inp_Q)
    begin
        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1)
                MULT_TEMP[i][j] = (inp_P[j] & inp_Q[i]);
        end
    end
    
    // assign Mult[0] = MULT_TEMP[0][0];
    // HalfAdder ha1(MULT_TEMP[0][1], MULT_TEMP[1][0], SUM_TEMP1[0], CarryTMP11);
    // FullAdder fa1(MULT_TEMP[0][2], MULT_TEMP[1][1], CarryTMP11, SUM_TEMP1[1], CarryTMP12);
    // FullAdder fa2(MULT_TEMP[0][3], MULT_TEMP[1][2], CarryTMP12, SUM_TEMP1[2], CarryTMP13);
    // HalfAdder ha2(MULT_TEMP[1][3], CarryTMP13, SUM_TEMP1[3], CarryTMP14);
    // assign Mult[1] = SUM_TEMP1[0];

    // HalfAdder ha3(SUM_TEMP1[1], MULT_TEMP[2][0], SUM_TEMP2[0], CarryTMP21);
    // FullAdder fa3(SUM_TEMP1[2], MULT_TEMP[2][1], CarryTMP21, SUM_TEMP2[1], CarryTMP22);
    // FullAdder fa4(SUM_TEMP1[3], MULT_TEMP[2][2], CarryTMP22, SUM_TEMP2[2], CarryTMP23);
    // FullAdder fa5(CarryTMP14, MULT_TEMP[2][3], CarryTMP23, SUM_TEMP2[3], CarryTMP24);
    // assign Mult[2] = SUM_TEMP2[0];

    // HalfAdder ha4(SUM_TEMP2[1], MULT_TEMP[3][0], SUM_TEMP3[0], CarryTMP31);
    // FullAdder fa6(SUM_TEMP2[2], MULT_TEMP[3][1], CarryTMP31, SUM_TEMP3[1], CarryTMP32);
    // FullAdder fa7(SUM_TEMP2[3], MULT_TEMP[3][2], CarryTMP32, SUM_TEMP3[2], CarryTMP33);
    // FullAdder fa8(CarryTMP24, MULT_TEMP[3][3], CarryTMP33, SUM_TEMP3[3], CarryTMP34);
    // assign Mult[3] = SUM_TEMP3[0];
    // assign Mult[4] = SUM_TEMP3[1];
    // assign Mult[5] = SUM_TEMP3[2];
    // assign Mult[6] = SUM_TEMP3[3];
    // assign Mult[7] = CarryTMP34;

    assign Mult[0] = MULT_TEMP[0][0];
    HalfAdder ha1(MULT_TEMP[0][1], MULT_TEMP[1][0], SUM_TEMP1[0], CarryTMP11);
    FullAdder fa1(MULT_TEMP[0][2], MULT_TEMP[1][1], MULT_TEMP[2][0], SUM_TEMP1[1], CarryTMP12);
    FullAdder fa2(MULT_TEMP[0][3], MULT_TEMP[1][2], MULT_TEMP[2][1], SUM_TEMP1[2], CarryTMP13);
    HalfAdder ha2(MULT_TEMP[1][3], MULT_TEMP[2][2], SUM_TEMP1[3], CarryTMP14);

    assign Mult[1] = SUM_TEMP1[0];
    HalfAdder ha3(SUM_TEMP1[1],CarryTMP11, SUM_TEMP2[0], CarryTMP21);
    FullAdder fa3(SUM_TEMP1[2], CarryTMP12, MULT_TEMP[3][0], SUM_TEMP2[1], CarryTMP22);
    FullAdder fa4(SUM_TEMP1[3], CarryTMP13, MULT_TEMP[3][1], SUM_TEMP2[2], CarryTMP23);
    FullAdder fa5(CarryTMP14, MULT_TEMP[2][3], MULT_TEMP[3][2], SUM_TEMP2[3], CarryTMP24);

    assign Mult[2] = SUM_TEMP2[0];
    HalfAdder ha4(SUM_TEMP2[1], CarryTMP21, SUM_TEMP3[0], CarryTMP31);
    FullAdder fa6(SUM_TEMP2[2], CarryTMP22, CarryTMP31, SUM_TEMP3[1], CarryTMP32);
    FullAdder fa7(SUM_TEMP2[3], CarryTMP23, CarryTMP32, SUM_TEMP3[2], CarryTMP33);
    FullAdder fa8(CarryTMP24, MULT_TEMP[3][3], CarryTMP33, SUM_TEMP3[3], CarryTMP34);
    assign Mult[3] = SUM_TEMP3[0];
    assign Mult[4] = SUM_TEMP3[1];
    assign Mult[5] = SUM_TEMP3[2];
    assign Mult[6] = SUM_TEMP3[3];
    assign Mult[7] = CarryTMP34;

endmodule

module WallaceTreeMult_TestBench();
    reg [3:0] P, Q;
    wire [7:0] Mult;
    WallaceTreeMult WTMult(P, Q, Mult);
    
    initial begin
        $dumpfile("WallaceTreeMult.vcd");
        $dumpvars(0, WallaceTreeMult_TestBench);
        P = 2; Q = 3; #10;
        $display("P = %b, Q = %b, Mult = %b", P, Q, Mult);
        P = 7; Q = 3; #10;
        $display("P = %b, Q = %b, Mult = %b", P, Q, Mult);
        P = 6; Q = 12; #10;
        $display("P = %b, Q = %b, Mult = %b", P, Q, Mult);
        P = 15; Q = 10; #10;
        $display("P = %b, Q = %b, Mult = %b", P, Q, Mult);
        P = 15; Q = 12; #10;
        $display("P = %b, Q = %b, Mult = %b", P, Q, Mult);
        P = 15; Q = 14; #10;
        $display("P = %b, Q = %b, Mult = %b", P, Q, Mult);
        P = 15; Q = 15; #10;
        $display("P = %b, Q = %b, Mult = %b", P, Q, Mult);
        $finish;
    end
endmodule