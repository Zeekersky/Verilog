module melayFSM(input CLK, RST, A, B, output reg out);
    localparam S0 = 0,
               S1 = 1,
               S2 = 2;

    reg [1:0] State;

    always @(posedge CLK) begin
        if(RST)
            State <= S0;
        else begin
            case(State)
            S0:
                begin
                    if(A) begin
                        out <= 0;
                        State <= S1;
                    end
                    else if(!A) begin
                        out <= 0;
                        State <= S0;
                    end
                    else begin
                        out <= 1'bz;
                        State <= 2'bzz;
                    end
                end
            S1:
                begin
                    if(B) begin
                        out <= 0;
                        State <= S2;
                    end
                    else if(!B) begin
                        out <= 0;
                        State <= S0;
                    end
                    else begin
                        out <= 1'bz;
                        State <= 2'bzz;
                    end
                end
            S2:
                begin
                    if(!A | !B) begin
                        out <= 0;
                        State <= S0;
                    end
                    else if(A & B) begin
                        out <= 1;
                        State <= S2;
                    end
                    else begin
                        out <= 1'bz;
                        State <= 2'bzz;
                    end
                end
            default:
                begin
                    out <= 1'bz;
                    State <= 1'bz;
                end
            endcase
        end
    end

endmodule

module melayFSM_testbench;
    reg clk, A, B, reset;
    wire [1:0]CurrentState;
    wire out;
    melayFSM M(clk, reset, A, B, out);
    always #2 clk = ~clk;

    initial begin
        $dumpfile("melayFSM.vcd");
        $dumpvars;

        reset = 1; clk = 0; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        reset = 0;
        A = 1; B = 1'bz; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        A = 1'bz; B = 1; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        A = 1; B = 1; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        A = 1; B = 1; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        A = 0; B = 1; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        A = 1; B = 0; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        A = 1'bz; B = 1; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        A = 1; B = 1; #4;
        $display("CLK = %b, Reset = %b, A = %b, B = %b, Out = %b", clk, reset, A, B, out);
        $finish;
    end
endmodule
