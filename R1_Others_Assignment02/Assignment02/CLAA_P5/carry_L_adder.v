module fulladder (input I0,I1,input Cin,output sum,output Cout);

assign sum= I0^ I1 ^ Cin;
assign Cout= ((I0 ^ I1) & Cin) | (I0 & I1);
endmodule

module carry(input [3:0]A,input [3:0]B,input Cin,output[3:0]C);

assign C[0]=(A[0] & B[0]) | (Cin & (A[0] ^ B[0]));
assign C[1]=(A[1] & B[1]) | ((A[1] ^ B[1])&(A[0]&B[0])) | ((A[1] ^ B[1]) & (A[0] ^ B[0]) & Cin); 
assign C[2]=(A[2] & B[2]) | ((A[2] ^ B[2]) & (A[1] & B[1])) | ((A[2] ^ B[2]) & (A[1] ^ B[1]) & (A[0] ^ B[0]) & Cin);
assign C[3]=(A[3] & B[3]) | ((A[3] & B[3]) & (A[2] & B[2]) | ((A[2] ^ B[2]) & (A[1] & B[1])) | ((A[2] ^ B[2]) & (A[1] ^ B[1]) & (A[0] ^ B[0]) & Cin));
endmodule

module carry_lookahead_adder(input [3:0]A,input [3:0]B,input Cin,output[3:0]sum,output Cout);
wire [3:0]C;
wire [3:0]c;
carry c1(A[3:0],B[3:0],Cin,C[3:0]);
fulladder f1(A[0],B[0],Cin,sum[0],c[0]);
fulladder f2(A[1],A[1],C[0],sum[1],c[1]);
fulladder f3(A[2],B[2],C[1],sum[2],c[2]);
fulladder f4(A[3],B[3],C[2],sum[3],c[3]);
assign Cout=C[3];

endmodule

module carry_lookahead_adder_tb;

reg [3:0]A;
reg [3:0]B;
reg Cin;
wire [3:0]sum;
wire Cout;
carry_lookahead_adder ans(A,B,Cin,sum,Cout);
initial begin
$dumpfile ("cla.vcd");
$dumpvars;
A=0;B=0;Cin=0;
#5;
$display("A=%d, B=%d, Cin=%d, Sum=%d, Cout=%d",A,B,Cin,sum,Cout);
A=1;B=1;Cin=0;
#5;
$display("A=%d, B=%d, Cin=%d, Sum=%d, Cout=%d",A,B,Cin,sum,Cout);
A=2;B=2;Cin=0;
#5;
$display("A=%d, B=%d, Cin=%d, Sum=%d, Cout=%d",A,B,Cin,sum,Cout);
A=3;B=3;Cin=0;
#5;
$display("A=%d, B=%d, Cin=%d, Sum=%d, Cout=%d",A,B,Cin,sum,Cout);
A=4;B=4;Cin=0;
#5;
$display("A=%d, B=%d, Cin=%d, Sum=%d, Cout=%d",A,B,Cin,sum,Cout);
A=5;B=5;Cin=0;
#5;
$display("A=%d, B=%d, Cin=%d, Sum=%d, Cout=%d",A,B,Cin,sum,Cout);
A=6;B=6;Cin=0;
#5;
$display("A=%d, B=%d, Cin=%d, Sum=%d, Cout=%d",A,B,Cin,sum,Cout);
A=7;B=10;Cin=0;
#5;
$display("A=%d, B=%d, Cin=%d, Sum=%d, Cout=%d",A,B,Cin,sum,Cout);

A=8;B=8;Cin=0;
#5;
A=9;B=9;Cin=0;
#5;
A=10;B=10;Cin=0;
#5;
A=11;B=11;Cin=0;
#5;
A=12;B=12;Cin=0;
#5;
A=13;B=13;Cin=0;
#5;
A=14;B=14;Cin=0;
#5;
A=15;B=15;Cin=0;
#5;
$finish();
end

endmodule