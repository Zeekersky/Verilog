module MultBy2 (input [3:0] a, output [4:0] b);
    assign b = a << 1;
endmodule

module MultBy2_tb();
    reg [3:0] a;
    wire [4:0] b;

    MultBy2 mult2 (a, b);

    initial
    begin
        $dumpfile("MultBy2_tb.vcd");
        $dumpvars(0, MultBy2_tb);
        a = 7; #10;
        $display("input = %d, output = %d", a, b);
        a = 8; #10;
        $display("input = %d, output = %d", a, b);
        $finish;
    end
endmodule