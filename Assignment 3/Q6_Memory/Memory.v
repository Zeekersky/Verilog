module memory(input CLK, input WE, input [6:0] WriteADDR, 
    input [6:0] ReadADDR, input [15:0] input_data, 
    output reg [15:0] output_WriteDATA, output reg [15:0] output_ReadDATA);
    reg [0:15] mem[0:127];

    always @ (posedge CLK) begin
        if (WE) begin
            mem[WriteADDR] = input_data;
            output_WriteDATA = mem[WriteADDR];
        end else
            output_ReadDATA = mem[ReadADDR];
    end
endmodule

module mem_testbench;
    reg CLK, WE;
    reg [6:0] WriteADDR, ReadADDR;
    reg [15:0] input_data;
    wire [15:0] output_WriteDATA, output_ReadDATA;
    integer clk_pulse; // For generating the clockpulse
    memory memory_inst (CLK, WE, WriteADDR, ReadADDR, input_data, output_WriteDATA, output_ReadDATA);
    initial begin
        $dumpfile("memory_tb.vcd");
        $dumpvars(0, mem_testbench);
        $display("WE CLK   | WriteADDR  ReadADDR     input_data      output_WriteDATA   output_ReadDATA");
        #1;
        WE = 1; WriteADDR = 1; input_data = 7; #4;
        WE = 1; WriteADDR = 3; input_data = 10; #4;
        WE = 1; WriteADDR = 127; input_data = 15; #4;
        WE = 1; WriteADDR = 5; input_data = 16'b1111111111111111; #4;
        WE = 0; ReadADDR = 1; #4;
        WE = 0; ReadADDR = 3; #4;
        WE = 0; ReadADDR = 5; #4;
        WE = 0; ReadADDR = 127; #4;
        WE = 0; ReadADDR = 5; #4;
        $finish;
    end
    always @ (negedge CLK) begin
        $display(" %b   %b    | %b   %b   %b   %b   %b", WE, CLK, WriteADDR, ReadADDR, input_data, output_WriteDATA, output_ReadDATA);
    end
    initial begin
        CLK = 0;
        for(clk_pulse = 0; clk_pulse < 18; clk_pulse = clk_pulse + 1) begin
            #2 CLK = ~CLK;
        end
    end
endmodule
