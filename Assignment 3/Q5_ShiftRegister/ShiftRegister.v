/*
    For dir = 1, BiDir_ShiftRegister module performs Right Shift
    For dir = 0, BiDir_ShiftRegister module performs left Shift
*/
module BiDir_ShiftRegister#(parameter N = 4)(input CLK, RST, dir, input_data, output reg [N-1:0] output_data);
    integer i;
    always @(posedge CLK) begin
        if (RST)
            output_data[N-1] <= 0;
        else begin
            if (dir)
                output_data[N-1] <= input_data;
            else if (!dir)
                output_data[N-1] <= output_data[N-2];
        end
    end

    always @(posedge CLK) begin
        for(i = 1; i <= N-2; i=i+1) begin
            if (RST)
                output_data[i] <= 0;
            else begin
                if (dir)
                    output_data[i] <= output_data[i+1];
                else if (!dir)
                    output_data[i] <= output_data[i-1];
            end
        end
    end

    always @(posedge CLK) begin
        if (RST)
            output_data[0] <= 0;
        else begin
            if (dir)
                output_data[0] <= output_data[1];
            else if (!dir)
                output_data[0] <= input_data;
        end
    end
endmodule

module BiDir_ShiftRegister_tb;
    reg CLK, RST, dir, input_data;
    wire [2:0] output_data;
    integer clk_pulse; // For generating the clockpulse
    BiDir_ShiftRegister #(3) BiDir_ShiftRegister_inst (CLK, RST, dir, input_data, output_data);
    initial begin
        $dumpfile("BiDir_ShiftRegister_tb.vcd");
        $dumpvars(0, BiDir_ShiftRegister_tb);
        $display("RST DIR CLK   | Input Output");
        // RST = 1 -> Q value will be reset to 0
        // RST = 0 -> Q value will be set according to logic
        #1;
        repeat (15) begin
            RST = 0; dir = 1;
            input_data = $random;
            @ (negedge CLK); #1;
        end
        repeat (15) begin
            input_data = $random; dir = 0;
            @ (negedge CLK); #1;
        end
        repeat (4) begin
            RST = 1; dir = 0;
            input_data = $random;
            @ (negedge CLK); #1;
        end
        $finish;
    end
    always @ (negedge CLK) begin
        $display(" %b  %b    %b    | %b     %b", RST, dir, CLK, input_data, output_data);
    end
    initial begin
        CLK = 0;
        for(clk_pulse = 0; clk_pulse < 64; clk_pulse = clk_pulse + 1) begin
            #1 CLK = ~CLK;
        end
    end
endmodule