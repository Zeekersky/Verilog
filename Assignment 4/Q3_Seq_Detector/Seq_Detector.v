module mooreFSM_SeqDetector(input CLK, RST, in, output reg out);
    localparam S_Start = 0,
               S_1 = 1,
               S_11 = 2,
               S_110 = 3,
               S_1101 = 4;


    reg [2:0] CurrentState;
    reg [2:0] NextState;

    always @(posedge CLK) begin
        if(RST)
            CurrentState <= S_Start;
        else
            CurrentState <= NextState;
    end

    always @(*) begin
        case(CurrentState)
        S_Start:
            begin
                if(in) NextState <= S_1;
                else NextState <= S_Start;
            end
        S_1:
            begin
                if(in) NextState <= S_11;
                else NextState <= S_Start;
            end
        S_11:  
            begin
                if(in) NextState <= S_11;
                else NextState <= S_110;
            end
        S_110:  
            begin
                if(in) NextState <= S_1101;
                else NextState <= S_Start;
            end
        S_1101: if(in) NextState <= S_1;
                else NextState <= S_Start;
        endcase
    end

    always @(*) begin
        if (CurrentState == S_1101)
            out <= 1;
        else out <= 0;
    end
endmodule

module mooreFSM_SeqDetector_testbench;
    reg clk, in, reset;
    wire out;
    mooreFSM_SeqDetector M(clk, reset, in, out);
    always #2 clk = ~clk;

    initial begin
        $dumpfile("mooreFSM_SeqDetector.vcd");
        $dumpvars;

        reset = 1; clk = 0; #4
        $display("CLK = %b, Reset = %b, in = %b, Out = %b", clk, reset, in, out);
        reset = 0;
        in = 1; #4;
        $display("CLK = %b, Reset = %b, in = %b, Out = %b", clk, reset, in, out);
        in = 1; #4;
        $display("CLK = %b, Reset = %b, in = %b, Out = %b", clk, reset, in, out);
        in = 0; #4;
        $display("CLK = %b, Reset = %b, in = %b, Out = %b", clk, reset, in, out);
        in = 1; #4;
        $display("CLK = %b, Reset = %b, in = %b, Out = %b", clk, reset, in, out);
        in = 0; #4;
        $display("CLK = %b, Reset = %b, in = %b, Out = %b", clk, reset, in, out);
        in = 1; #4;
        $display("CLK = %b, Reset = %b, in = %b, Out = %b", clk, reset, in, out);
        in = 1; #4;
        $display("CLK = %b, Reset = %b, in = %b, Out = %b", clk, reset, in, out);
        in = 1; #4;
        $display("CLK = %b, Reset = %b, in = %b, Out = %b", clk, reset, in, out);
        in = 0; #4;
        $display("CLK = %b, Reset = %b, in = %b, Out = %b", clk, reset, in, out);
        in = 1; #4;
        $display("CLK = %b, Reset = %b, in = %b, Out = %b", clk, reset, in, out);
        $finish;
    end
endmodule
