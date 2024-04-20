module halfadder(input A,input B,output S,output C);
wire w1,w2,w3,w4;
not o1(w1,A);
not o2(w2,B);
and o3(w3,w1,B);
and o4(w4,w2,A);
or o5(S,w3,w4);
and o6(C,A,B);

endmodule

module fulladder(input A,input B,input C,output S,output Cin);
wire w1,w2,w3;
halfadder h1(.A(A),.B(B),.S(w1),.C(w2));
halfadder h2(.A(w1),.B(C),.S(S),.C(w3));
or g1(Cin,w3,w2);
endmodule

module add(input [3:0]A,input [3:0]B,output [7:0]sum);
wire w1,w2,w3;
fulladder f1(A[0],B[0],1'b0,sum[0],w1);
fulladder f2(A[1],B[1],w1,sum[1],w2);
fulladder f3(A[2],B[2],w2,sum[2],w3);
fulladder f4(A[3],B[3],w3,sum[3],sum[4]);
and (sum[5],1'b0,sum[4]);
and (sum[6],1'b0,sum[4]);
and (sum[7],1'b0,sum[4]);
endmodule

// SUB

module halfsub(input A,input B,output D,output Bor);
wire w1,w2,w3,w4;
not o1(w1,A);
not o2(w2,B);
and o3(w3,w1,B);
and o4(w4,w2,A);
or o5(D,w3,w4);
and o6(Bor,w1,B);
endmodule

module fullsub(input A,input B,input C,output D,output Bout);
wire w1,w2,w3;
halfsub h1(.A(A),.B(B),.D(w1),.Bor(w2));
halfsub h2(.A(w1),.B(C),.D(D),.Bor(w3));
or g1(Bout,w3,w2);
endmodule


module sub(input [3:0]A,input [3:0]B,output[7:0]out);
wire w1,w2,w3,w4;
fullsub d1(A[0],B[0],1'b0,out[0],w1);
fullsub d2(A[1],B[1],w1,out[1],w2);
fullsub d3(A[2],B[2],w2,out[2],w3);
fullsub d4(A[3],B[3],w3,out[3],out[4]);
xor (out[5],1'b0,out[4]);
xor (out[6],1'b0,out[4]);
xor (out[7],1'b0,out[4]);
endmodule

// MULTI

module multi(input [3:0]A,input [3:0]B,output [7:0]out);
wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17,w18,w19,w20,w21,w22,w23,o1,o2,o3,o4,o5,o6;
and (out[0],A[0],B[0]);
and (w1,A[1],B[0]);
and (w2,A[2],B[0]);
and (w3,A[3],B[0]);
and (w4,A[0],B[1]);
and (w5,A[1],B[1]);
and (w6,A[2],B[1]);
and (w7,A[3],B[1]);
add a1({1'b0,w3,w2,w1},{w7,w6,w5,w4},{o1,o2,o3,w11,w10,w9,w8,out[1]});
and (w12,A[0],B[2]);
and (w13,A[1],B[2]);
and (w14,A[2],B[2]);
and (w15,A[3],B[2]);
add a2({w11,w10,w9,w8},{w15,w14,w13,w12},{o4,o5,o6,w19,w18,w17,w16,out[2]});
and (w20,A[0],B[3]);
and (w21,A[1],B[3]);
and (w22,A[2],B[3]);
and (w23,A[3],B[3]);
add a3({w19,w18,w17,w16},{w23,w22,w21,w20},{w26,w25,w24,out[7],out[6],out[5],out[4],out[3]});
endmodule

module andd(input [3:0]A,input [3:0]B,output [7:0]out);
and(out[0],A[0],B[0]); 
and(out[1],A[1],B[1]); 
and(out[2],A[2],B[2]); 
and(out[3],A[3],B[3]); 
and(out[4],1'b0);
and(out[5],1'b0);
and(out[6],1'b0);
and(out[7],1'b0);
endmodule

module orr(input [3:0]A,input [3:0]B,output [7:0]out);
or(out[0],A[0],B[0]); 
or(out[1],A[1],B[1]); 
or(out[2],A[2],B[2]); 
or(out[3],A[3],B[3]); 
and(out[4],1'b0);
and(out[5],1'b0);
and(out[6],1'b0);
and(out[7],1'b0);
endmodule

module XOR(input [3:0]A,input [3:0]B,output [7:0]out);
xor(out[0],A[0],B[0]); 
xor(out[1],A[1],B[1]); 
xor(out[2],A[2],B[2]); 
xor(out[3],A[3],B[3]); 
and(out[4],1'b0);
and(out[5],1'b0);
and(out[6],1'b0);
and(out[7],1'b0);
endmodule

module fmux(input A,input B,input  C,input D,input [1:0] S,output out);
wire w1,w2,w3,w4,w5,w6;
not (w1,S[1]);
not (w2,S[0]);
and (w3,A,w1,w2);
and (w4,B,w1,S[0]);
and (w5,C,S[1],w2);
and (w6,D,S[1],S[0]);
or (out,w3,w4,w5,w6);
endmodule
module smux(input A,input B,input S,output out);
wire w1,w2,w3;
not(w1,S);
and(w2,A,w1);
and(w3,B,S);
or(out,w2,w3);
endmodule
module mux(input [7:0]A,input [2:0]S,output out);
wire w1,w2;
fmux f1(A[0],A[1],A[2],A[3],S[1:0],w1);
fmux f2(A[4],A[5],A[6],A[7],S[1:0],w2);
smux s1(w1,w2,S[2],out);
endmodule

module alu(input [3:0]A,input [3:0]B,input [2:0]S,output [7:0]out);
wire [7:0]w1;
wire [7:0]w2;
wire [7:0]w3;
wire [7:0]w4;
wire [7:0]w5;
wire [7:0]w6;
add a1(A,B,w1);
sub a2(A,B,w2);

multi a3(A,B,w3);
andd a4(A,B,w4);
orr a5(A,B,w5);
XOR a6(A,B,w6);

mux m1({1'b0,1'b0,w6[0],w5[0],w4[0],w3[0],w2[0],w1[0]},{S[2],S[1],S[0]},out[0]);
mux m2({1'b0,1'b0,w6[1],w5[1],w4[1],w3[1],w2[1],w1[1]},{S[2],S[1],S[0]},out[1]);
mux m3({1'b0,1'b0,w6[2],w5[2],w4[2],w3[2],w2[2],w1[2]},{S[2],S[1],S[0]},out[2]);
mux m4({1'b0,1'b0,w6[3],w5[3],w4[3],w3[3],w2[3],w1[3]},{S[2],S[1],S[0]},out[3]);
mux m5({1'b0,1'b0,w6[4],w5[4],w4[4],w3[4],w2[4],w1[4]},{S[2],S[1],S[0]},out[4]);
mux m6({1'b0,1'b0,w6[5],w5[5],w4[5],w3[5],w2[5],w1[5]},{S[2],S[1],S[0]},out[5]);
mux m7({1'b0,1'b0,w6[6],w5[6],w4[6],w3[6],w2[6],w1[6]},{S[2],S[1],S[0]},out[6]);
mux m8({1'b0,1'b0,w6[7],w5[7],w4[7],w3[7],w2[7],w1[7]},{S[2],S[1],S[0]},out[7]);


endmodule


module alu_tb;
reg [3:0]A;
reg [3:0]B;
reg [2:0]S;
wire [7:0]out;
alu ans(A,B,S,out);
initial begin
    $dumpfile("alu.vcd");
    $dumpvars;
   A=4;
   B=2;
   S=0;
   #5;
   $display("A=%d, B=%d, S=%d, out=%d",A,B,S,out);
   A=2;
   B=3;
   S=1;
   #5;
   $display("A=%d, B=%d, S=%d, out=%d",A,B,S,out);
   A=6;
   B=2;
   S=2;
   #5;
   $display("A=%d, B=%d, S=%d, out=%d",A,B,S,out);
   A=3;
   B=4;
   S=3;
   #5;
   $display("A=%d, B=%d, S=%d, out=%d",A,B,S,out);
   A=6;
   B=2;
   S=4;
   #5;
   $display("A=%d, B=%d, S=%d, out=%d",A,B,S,out);
   A=3;
   B=9;
   S=5;
   #5;
   $display("A=%d, B=%d, S=%d, out=%d",A,B,S,out);
   A=3;
   B=2;
   S=6;
   #5;
   $display("A=%d, B=%d, S=%d, out=%d",A,B,S,out);
   A=2;
   B=4;
   S=7;
   #5;
   $display("A=%d, B=%d, S=%d, out=%d",A,B,S,out);

    $finish();
end

endmodule




