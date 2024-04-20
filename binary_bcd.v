module binary_bcd(input [3:0] data, output reg [4:0] out);
    always @(data) begin
        if (data <= 9) begin
            out[3:0] = data;
            out[4] = 0;
        end
        else begin
            out[3:0] = data - 10;
            out[4] = 1;
        end
    end
endmodule

module test();
    reg [3:0] in;
    wire [4:0] out;
    binary_bcd bncd(in, out);
    initial begin
        in = 12; #10;
        $display("In : %b, Out: %b", in, out);
        in = 9; #10;
        $display("In : %b, Out: %b", in, out);
        $finish;
    end
endmodule