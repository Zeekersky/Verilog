module OR(input a, input b, input c, output y);

    wire w1;
    or gate1(w1, a, b);
    or gate2(y, w1, c);

endmodule

module OR_TestBench();

    reg A, B, C;
    wire Y;

    OR gate1 (A, B, C, Y);

    initial begin

        $dumpfile("3-input_OR.vcd");
        $dumpvars(0, OR_TestBench);

        A = 0; B = 0; C = 0;
        #10 A = 1; B = 0; C = 0;
        #10 A = 0; B = 1; C = 0;
        #10 A = 1; B = 1; C = 0;
        #10 A = 0; B = 0; C = 1;
        #10 A = 1; B = 0; C = 1;
        #10 A = 0; B = 1; C = 1;
        #10 A = 1; B = 1; C = 1;
        #10 $finish;
    end

endmodule