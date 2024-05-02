module mooreFSM(input CLK, RST, A, B, output reg out);
    localparam S_res0 = 0,
               S_res1 = 1,
               S_res2 = 2,
               S_res3 = 3;

    reg [1:0] CurrentState;
    reg [1:0] NextState;

    always @(posedge CLK) begin
        if(RST)
            CurrentState <= S_res0;
        else
            CurrentState <= NextState;
    end

    always @(*) begin
        case(CurrentState)
        S_res0:
            begin
                if(!A & !B) NextState <= S_res0;
                else if(!A & B) NextState <= S_res1;
                else if(A & !B) NextState <= S_res2;
                else if(A & B) NextState <= S_res3;
                else NextState <= 2'bzz;
            end
        S_res1:
            begin
                if(!A & !B) NextState <= S_res1;
                else if(!A & B) NextState <= S_res2;
                else if(A & !B) NextState <= S_res3;
                else if(A & B) NextState <= S_res0;
                else NextState <= 2'bzz;
            end
        S_res2:  
            begin
                if(!A & !B) NextState <= S_res2;
                else if(!A & B) NextState <= S_res3;
                else if(A & !B) NextState <= S_res0;
                else if(A & B) NextState <= S_res1;
                else NextState <= 2'bzz;
            end
        S_res3:  
            begin
                if(!A & !B) NextState <= S_res3;
                else if(!A & B) NextState <= S_res0;
                else if(A & !B) NextState <= S_res1;
                else if(A & B) NextState <= S_res2;
                else NextState <= 2'bzz;
            end
        endcase
    end

    always @(*) begin
        if (CurrentState == S_res1)
            out <= 1;
        else if(CurrentState == S_res2 | CurrentState == S_res3 | CurrentState == S_res0) 
                out <= 0;
        else out <= 1'bz;
    end
endmodule

module mooreFSM_testbench;
    reg clk, A, B, reset;
    wire out;
    mooreFSM M(clk, reset, A, B, out);
    always #2 clk = ~clk;

    initial begin
        $dumpfile("ModEq.vcd");
        $dumpvars;

        reset = 1; clk = 0; #4
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        reset = 0;
        A = 1; B = 1; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        A = 0; B = 1; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        A = 0; B = 1; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        A = 1; B = 0; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        A = 1; B = 1; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        A = 1; B = 1; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        $finish;
    end
endmodule
