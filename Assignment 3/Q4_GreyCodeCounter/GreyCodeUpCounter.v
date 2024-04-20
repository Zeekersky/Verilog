module counter_up(input CLK, RST, UP, output reg [2:0] Q);
    reg [2:0] Q_bin;
    always @(posedge CLK) begin
        if (RST) begin
            Q_bin <= 0;
            Q <= 0;
        end else begin
            if (UP)
                Q_bin = Q_bin + 1;
            else
                Q_bin = Q_bin;
            Q[0] <= Q_bin[0] ^ Q_bin[1];
            Q[1] <= Q_bin[1] ^ Q_bin[2];
            Q[2] <= Q_bin[2];
        end
    end
endmodule

module CounterUP_tb;
    reg CLK, RST, UP;
    wire [2:0] Q;
    integer clk_pulse; // For generating the clockpulse
    counter_up counter_inst (CLK, RST, UP, Q);
    initial begin
        $dumpfile("CounterUP_tb.vcd");
        $dumpvars(0, CounterUP_tb);
        $display("RST UP CLK   | Count");
        $monitor(" %b  %b   %b    | %b", RST, UP, CLK, Q);
        // RST = 1 -> Q value will be reset to 0
        // RST = 0 -> Q value will be set according to logic
        RST = 1; #1;
        RST = 0; UP = 1; #25
        RST = 0; UP = 0; #2
        RST = 1; UP = 1; #3
        $finish;
    end
    initial begin
        CLK = 1;
        for(clk_pulse = 0; clk_pulse < 32; clk_pulse = clk_pulse + 1) begin
            #1 CLK = ~CLK;
        end
    end
endmodule