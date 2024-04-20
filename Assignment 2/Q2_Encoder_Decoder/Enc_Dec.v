module Encoder4to2 (input [3:0] a, output [1:0] b);
    assign b[0] = a[1] | a[3];
    assign b[1] = a[2] | a[3];
endmodule

module Decoder2to4 (input [1:0] a, output [3:0] b);
    assign b[0] = ~a[0] & ~a[1];
    assign b[1] = a[0] & ~a[1];
    assign b[2] = ~a[0] & a[1];
    assign b[3] = a[0] & a[1];
endmodule

module Encoder4to2_tb();
    reg [3:0] enc_input;
    wire [1:0] enc_output;
    reg [1:0] dec_input;
    wire [3:0] dec_output;

    Encoder4to2 enc (enc_input, enc_output);
    Decoder2to4 dec (dec_input, dec_output);

    initial begin
        $dumpfile("Encoder4to2_tb.vcd");
        $dumpvars(0, Encoder4to2_tb);

        $display("Encoder: ");
        enc_input = 4'b0001; #10;
        $display("input = %b, output = %b", enc_input, enc_output);
        enc_input = 4'b0010; #10;
        $display("input = %b, output = %b", enc_input, enc_output);
        enc_input = 4'b0100; #10;
        $display("input = %b, output = %b", enc_input, enc_output);
        enc_input = 4'b1000; #10;
        $display("input = %b, output = %b", enc_input, enc_output);
        
        $display("Decoder: ");
        dec_input = 2'b00; #10;
        $display("input = %b, output = %b", dec_input, dec_output);
        dec_input = 2'b01; #10;
        $display("input = %b, output = %b", dec_input, dec_output);
        dec_input = 2'b10; #10;
        $display("input = %b, output = %b", dec_input, dec_output);
        dec_input = 2'b11; #10;
        $display("input = %b, output = %b", dec_input, dec_output);
        $finish;
    end
endmodule