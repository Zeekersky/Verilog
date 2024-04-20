module DLatch(input CLK, RST, D, output reg N1, N2, Q);
    always @(CLK) begin
        if (RST)
            Q <= 0;
        N1 <= #1 (D & CLK);
        N2 <= #2 (Q & (~CLK));
    end
    always @(N1, N2) begin
        if (RST)
            Q = 0;
        else
            Q = #1 (N1 | N2);
    end
endmodule

module DLatch_tb;
    reg D, CLK, RST;
    wire Q, N1, N2;
    integer clk_pulse;
    DLatch DLatch_inst (CLK, RST, D, N1, N2, Q);
    initial begin
        $dumpfile("DLatch_tb.vcd");
        $dumpvars(0, DLatch_tb);
        // RST = 1 -> Q value will be reset to 0
        // RST = 0 -> Q value will be set according to logic
        RST = 1; #4;
        $display("RST=%b, CLK=%b, D=%b, Q=%b", RST, CLK, D, Q);
        RST = 0;
        D = 0;
        #4 $display("RST=%b, CLK=%b, D=%b, Q=%b", RST, CLK, D, Q);
        D = 1;
        #4 $display("RST=%b, CLK=%b, D=%b, Q=%b", RST, CLK, D, Q);
        D = 1;
        #4 $display("RST=%b, CLK=%b, D=%b, Q=%b", RST, CLK, D, Q);
        D = 0;
        #4 $display("RST=%b, CLK=%b, D=%b, Q=%b", RST, CLK, D, Q);
        D = 1;
        #4 $display("RST=%b, CLK=%b, D=%b, Q=%b", RST, CLK, D, Q);
        D = 1;
        #4 $display("RST=%b, CLK=%b, D=%b, Q=%b", RST, CLK, D, Q);
        D = 0;
        #4 $display("RST=%b, CLK=%b, D=%b, Q=%b", RST, CLK, D, Q);
        D = 1;
        #4 $display("RST=%b, CLK=%b, D=%b, Q=%b", RST, CLK, D, Q);
        $finish;
    end
    initial begin
        CLK = 0;
        for(clk_pulse = 0; clk_pulse < 10; clk_pulse = clk_pulse + 1) begin
            #4 CLK = ~CLK;
        end
    end
endmodule
