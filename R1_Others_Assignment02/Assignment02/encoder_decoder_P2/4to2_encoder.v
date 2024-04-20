module encoder (input A0,A1,A2,A3,output[1:0]out);

assign out[1]=A3 | A2;
assign out[0]=A3 | A1;
    
endmodule


module encoder_tb;
reg A0,A1,A2,A3;
wire[1:0]out;
encoder ans(A0,A1,A2,A3,out);
initial begin
    $dumpfile("encoder.vcd");
    $dumpvars;
    A3=0;A2=0;A1=0;A0=1;
    #5;
    $display("A3=%d, A2=%d, A1=%d, A0=%d, Out=%d",A3,A2,A1,A0,out);
    A3=0;A2=0;A1=1;A0=0;
    #5;
    $display("A3=%d, A2=%d, A1=%d, A0=%d, Out=%d",A3,A2,A1,A0,out);
    A3=0;A2=1;A1=0;A0=0;
    #5;
    $display("A3=%d, A2=%d, A1=%d, A0=%d, Out=%d",A3,A2,A1,A0,out);
    A3=1;A2=0;A1=0;A0=0;
    #5;
    $display("A3=%d, A2=%d, A1=%d, A0=%d, Out=%d",A3,A2,A1,A0,out);
    $finish();
end

endmodule