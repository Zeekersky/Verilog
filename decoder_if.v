module decoder(input [1:0] in, output reg [3:0] out);
    always @(in) begin
        if (in == 2'b00)
            out <= 4'b0001;
        else if (in == 2'b01)
            out <= 4'b0010;
        else if (in == 2'b10)
            out <= 4'b0100;
        else if (in == 2'b11)
            out <= 4'b1000;
    end
endmodule

module decoder_testbench();
    reg [1:0] in;
    reg [3:0] out;
    decoder decoder_inst (in, out);
    initial begin
        in = 2'b00; #10;
        $display("in = %b, out = %b", in, out);
        in = 2'b01; #10;
        $display("in = %b, out = %b", in, out);
        in = 2'b10; #10;
        $display("in = %b, out = %b", in, out);
        in = 2'b11; #10;
        $display("in = %b, out = %b", in, out);
        $finish;
    end
endmodule