module SRLatch (input CLK, S, R, enable, reset, output reg Q, Qbar);
  always @(CLK, enable, reset) begin // Asynchronous Enable and Reset
    if (reset) begin
      Q <= 0;
      Qbar <= 1;
    end else if (enable) begin
      if (S && !R) begin
        Q <= 1;
        Qbar <= 0;
      end else if (!S && R) begin
        Q <= 0;
        Qbar <= 1;
      end else if (S && R) begin
        // Invalid State
        Q <= 0;
        Qbar <= 0;
      end else begin
        // Hold State
        Q <= Q;
        Qbar <= Qbar;
      end
    end
  end
endmodule

module SRLatch_tb;
  reg S, R, En, RST, CLK;
  wire Q, Qbar;
  integer clk_pulse;
  SRLatch SRLatch_inst (CLK, S, R, En, RST, Q, Qbar);
  initial begin
    $dumpfile("SRLatch_tb.vcd");
    $dumpvars(0, SRLatch_tb);
    // RST = 1 -> Q value will be reset to 0
    // RST = 0 -> Q value will be set according to logic
    En = 1; RST = 0;
    S = 0; R = 0;
    #10 $display("CLK=%b, S=%b, R=%b, En=%b, RST=%b, Q=%b, Qbar=%b", CLK, S, R, En, RST, Q, Qbar);
    S = 1; R = 1;
    #10 $display("CLK=%b, S=%b, R=%b, En=%b, RST=%b, Q=%b, Qbar=%b", CLK, S, R, En, RST, Q, Qbar);
    S = 0; R = 1;
    #10 $display("CLK=%b, S=%b, R=%b, En=%b, RST=%b, Q=%b, Qbar=%b", CLK, S, R, En, RST, Q, Qbar);
    S = 1; R = 0;
    #10 $display("CLK=%b, S=%b, R=%b, En=%b, RST=%b, Q=%b, Qbar=%b", CLK, S, R, En, RST, Q, Qbar);
    S = 0; R = 0;
    #10 $display("CLK=%b, S=%b, R=%b, En=%b, RST=%b, Q=%b, Qbar=%b", CLK, S, R, En, RST, Q, Qbar);
    En = 0; RST = 0;
    S = 0; R = 0;
    #10 $display("CLK=%b, S=%b, R=%b, En=%b, RST=%b, Q=%b, Qbar=%b", CLK, S, R, En, RST, Q, Qbar);
    En = 1; RST = 1;
    S = 1; R = 1;
    #10 $display("CLK=%b, S=%b, R=%b, En=%b, RST=%b, Q=%b, Qbar=%b", CLK, S, R, En, RST, Q, Qbar);
    $finish;
   end
   initial begin
      CLK = 1;
      for(clk_pulse = 0; clk_pulse < 8; clk_pulse = clk_pulse + 1) begin
          #10 CLK = ~CLK;
      end
    end
endmodule