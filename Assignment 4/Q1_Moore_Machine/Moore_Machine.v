module mooreFSM(input CLK, RST, A, B, output reg out);
    localparam S0 = 1,
               S1 = 2,
               S2 = 3;

    reg [1:0] CurrentState;
    reg [1:0] NextState;

    always @(posedge CLK) begin
        if(RST)
            CurrentState <= S0;
        else
            CurrentState <= NextState;
    end

    always @(*) begin
        case(CurrentState)
        S0:
            begin
                if(A) NextState <= S1;
                else if(!A) NextState <= S0;
                else NextState <= 2'bzz;
            end
        S1:
            begin
                if(B) NextState <= S2;
                else if(!B) NextState <= S0;
                else NextState <= 2'bzz;
            end
        S2:  
            begin
                if(A | !A | B | !B) NextState <= S0;
                else NextState <= 2'bzz;
            end
        endcase
    end

    always @(*) begin
        if (CurrentState == S2)
            out <= 1;
        else if(CurrentState == S1 | CurrentState == S0) out <= 0;
        else out <= 1'bz;
    end
endmodule

module mooreFSM_testbench;
    reg clk, A, B, reset;
    wire out;
    mooreFSM M(clk, reset, A, B, out);
    always #2 clk = ~clk;

    initial begin
        $dumpfile("mooreFSM.vcd");
        $dumpvars;

        reset = 1; clk = 0; #4
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        reset = 0;
        A = 1; B = 1'bz; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        A = 1'bz; B = 1; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        A = 1; B = 0; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        A = 0; B = 0; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        A = 1; B = 1; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        A = 0; B = 1; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        A = 1; B = 0; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        $finish;
    end
endmodule
