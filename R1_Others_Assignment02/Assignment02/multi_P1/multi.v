module multi(input [3:0]A,output[7:0]out);
assign out=A<<1;

endmodule

module multi_tb;
reg [3:0]A;
wire [7:0]out;
multi ans(A,out);
initial begin
    $dumpfile("multi.vcd");
    $dumpvars;
    A=2;
    #5;
    $display("A=%d, Out=%d",A,out);
    A=3;
    #5;
    A=7;
    #5;
    $display("A=%d, Out=%d",A,out);
    A=6;
    #5;
    $finish();
end

endmodule