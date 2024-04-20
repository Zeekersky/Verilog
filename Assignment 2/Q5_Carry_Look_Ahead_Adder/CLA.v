module CLA(input [3:0] inp_a, input [3:0] inp_b, input CarryIN, output [3:0] SUM, output CarryOUT);
    wire carry1, carry2, carry3;
    assign SUM[0] = inp_a[0] ^ inp_b[0] ^ CarryIN;
    assign carry1 = (inp_a[0] & inp_b[0]) | ((inp_a[0] ^ inp_b[0]) & CarryIN);
    assign SUM[1] = inp_a[1] ^ inp_b[1] ^ carry1;
    assign carry2 = (inp_a[1] & inp_b[1] | ((inp_a[1] ^ inp_b[1]) & ((inp_a[0] & inp_b[0]) | ((inp_a[0] ^ inp_b[0]) & CarryIN))));
    assign SUM[2] = inp_a[2] ^ inp_b[2] ^ carry2;
    assign carry3 = (inp_a[2] & inp_b[2] | ((inp_a[2] ^ inp_b[2]) & ((inp_a[1] & inp_b[1]) | ((inp_a[1] ^ inp_b[1]) & ((inp_a[0] & inp_b[0]) | ((inp_a[0] ^ inp_b[0]) & CarryIN))))));
    assign SUM[3] = inp_a[3] ^ inp_b[3] ^ carry3;
    assign CarryOUT = (inp_a[3] & inp_b[3] | ((inp_a[3] ^ inp_b[3]) & ((inp_a[2] & inp_b[2]) | ((inp_a[2] ^ inp_b[2]) & ((inp_a[1] & inp_b[1]) | ((inp_a[1] ^ inp_b[1]) & ((inp_a[0] & inp_b[0]) | ((inp_a[0] ^ inp_b[0]) & CarryIN))))))));
endmodule

module CLA_TestBench();
    reg [3:0] input_A, input_B;
    reg CarryIN;
    wire [3:0] SUM;
    wire CarryOUT;
    CLA uut(input_A, input_B, CarryIN, SUM, CarryOUT);

    initial begin
        $dumpfile("CLA.vcd");
        $dumpvars(0, CLA_TestBench);
        CarryIN = 0;

        input_A = 2; input_B = 3; #10;
        $display("A = %b, B = %b, SUM = %b, CarryOUT = %b", input_A, input_B, SUM, CarryOUT);
        input_A = 6; input_B = 12; #10;
        $display("A = %b, B = %b, SUM = %b, CarryOUT = %b", input_A, input_B, SUM, CarryOUT);
        input_A = 7; input_B = 15; #10;
        $display("A = %b, B = %b, SUM = %b, CarryOUT = %b", input_A, input_B, SUM, CarryOUT);
        input_A = 11; input_B = 15; #10;
        $display("A = %b, B = %b, SUM = %b, CarryOUT = %b", input_A, input_B, SUM, CarryOUT);
        $finish;
    end
endmodule