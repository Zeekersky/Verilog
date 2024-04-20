module counter(input CLK, RST, output reg [2:0] Q);
    always @(posedge CLK) begin
        if (RST)
            Q <= 0;
        else
            if (Q >= 3'b000)
                Q <= Q - 1;
            else
                Q <= 3'b111;
    end
endmodule

module Counter_tb;
    reg CLK, RST;
    wire [2:0] Q;
    integer clk_pulse; // For generating the clockpulse
    counter counter_inst (CLK, RST, Q);
    initial begin
        $dumpfile("Counter_tb.vcd");
        $dumpvars(0, Counter_tb);
        $display("RST CLK   | Count");
        $monitor(" %b   %b    | %b", RST, CLK, Q);
        // RST = 1 -> Q value will be reset to 0
        // RST = 0 -> Q value will be set according to logic
        RST = 0; #27
        RST = 1; #5
        $finish;
    end
    initial begin
        CLK = 1;
        for(clk_pulse = 0; clk_pulse < 32; clk_pulse = clk_pulse + 1) begin
            #1 CLK = ~CLK;
        end
    end
endmodule