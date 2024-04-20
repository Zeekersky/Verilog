module decoder(input[1:0]A,input E,output [3:0]out);

assign out[3]= E & A[1] & A[0];
assign out[2]= E & A[1] & ~A[0];
assign out[1]= E & ~A[1] & A[0];
assign out[0]= E & ~A[1] & ~A[0];
endmodule


module decoder_tb;
reg [1:0]A;
reg E;
wire[3:0]out;
decoder ans(A,E,out);
initial begin
    $dumpfile("decoder.vcd");
    $dumpvars;
    E=1;
    A=0;
    #5;
    $display("A=%d, E=%d, Out=%d",A,E,out);
    E=1;
    A=1;
    #5;
    $display("A=%d, E=%d, Out=%d",A,E,out);
    E=1;
    A=2;
    #5;
    $display("A=%d, E=%d, Out=%d",A,E,out);
    E=1;
    A=3;
    #5;
    $display("A=%d, E=%d, Out=%d",A,E,out);
    E=0;
    A=0;
    #5;
    $display("A=%d, E=%d, Out=%d",A,E,out);
    E=0;
    A=1;
    #5;
    $display("A=%d, E=%d, Out=%d",A,E,out);
    E=0;
    A=2;
    #5;
    $display("A=%d, E=%d, Out=%d",A,E,out);
    E=0;
    A=3;
    #5;
    $display("A=%d, E=%d, Out=%d",A,E,out);
    $finish();
end

endmodule