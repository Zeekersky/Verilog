module fulladder (input I0,I1,input Cin,output sum,output Cout);
assign sum= I0^ I1 ^ Cin;
assign Cout= ((I0 ^ I1) & Cin) | (I0 & I1);
endmodule

module halfadder(input I0,I1,output sum,Cout);

assign sum=I0 ^ I1;
assign Cout=I0 & I1;
endmodule

module wallace_tree_multiplier(input [3:0]A,input [3:0]B,output [7:0]out);
wire [7:0]I0;
wire [6:0]I1;
wire [5:0]I2;
wire [4:0]I3;
wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17,w18,w19,w20,w21,w22,w23,w24,w25,w26,w27,w28,w29,w30;
genvar   i;
generate
    for(i=0;i<4;i=i+1)begin
        assign I0[i]=A[i]&B[0];
        assign I1[i]=A[i]&B[1];
        assign I2[i]=A[i]&B[2];
        assign I3[i]=A[i]&B[3];
        
end
    
endgenerate

// end 

assign I0[7:4]=4'b0000 ;
assign I1[6:4]=3'b000;
assign I2[5:4]=2'b00;
assign I3[4]=1'b0;

// out[0]
assign out[0]=I0[0];

//out[1]
halfadder h1(I0[1],I1[0],out[1],w1);

//out[2]
halfadder h2(I2[0],I1[1],w2,w3);
fulladder f1(w2,I0[2],w1,out[2],w4);

//out[3]
fulladder f2(I3[0],I2[1],I1[2],w5,w6);
halfadder h3(w5,I0[3],w7,w8);
fulladder f3(w7,w3,w4,out[3],w10);

//out[4]
fulladder f4(I3[1],I2[2],I1[3],w11,w12);
fulladder f5(w11,I0[4],w6,w13,w14);
fulladder f6(w13,w8,w10,out[4],w15);

//out[5]
fulladder f7(I3[2],I2[3],I1[4],w16,w17);
fulladder f8(w16,I0[5],w12,w18,w19);
fulladder f9(w18,w14,w15,out[5],w20);

//out[6]
fulladder f10(I3[3],I2[4],I1[5],w21,w22);
fulladder f11(w21,I0[6],w17,w23,w24);
fulladder f12(w23,w19,w20,out[6],w25);

//out[7]
fulladder f13(I3[4],I2[5],I1[6],w26,w27);
fulladder f14(w26,I0[7],w22,w28,w29);
fulladder f15(w28,w24,w25,out[7],w30);


endmodule 

module wallace_tree_multiplier_tb;

reg [3:0]A;
reg [3:0]B;
wire [7:0]out;
wallace_tree_multiplier ans(A,B,out);
initial begin
    $dumpfile("wallace_tree_multiplier.vcd");
    $dumpvars;
    A=3;
    B=4;
    #10;
    $display("A=%d, B=%d, Out=%d",A,B,out);
    A=5;
    B=2;
    #10;
    $display("A=%d, B=%d, Out=%d",A,B,out);
    A=4;
    B=4;
    #10;
    A=3;
    B=5;
    #10;
    A=6;
    B=2;
    #10;
    A=12;
    B=13;
    #10;
    $display("A=%d, B=%d, Out=%d",A,B,out);
    A=10;
    B=15;
    #10;
    $display("A=%d, B=%d, Out=%d",A,B,out);

    $finish();
end
endmodule