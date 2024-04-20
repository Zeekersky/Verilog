module mux (input [2:0]S,input E,input [7:0] I,output out);

// assign out= E &((~S[2] & ~S[1] & ~S[0] & I[0]) | (S[0] & ~S[1] & ~S[2] & I[1]) | (~S[0] & ~S[2] & S[1] & I[2]) | (~S[2] & S[1] & S[0] & I[3]) | (~S[0] & ~S[1] & S[2] & I[4]) | (~S[1] & S[0] & S[2] & I[5]) | (~S[0] & S[1] & S[2] & I[6]) | (S[0] & S[1] & S[2] & I[7]));
reg out;
always@(*) begin
case(S)
3'b000: out=E&I[0];
3'b001: out=E&I[1];
3'b010: out=E&I[2];
3'b011: out=E&I[3];
3'b100: out=E&I[4];
3'b101: out=E&I[5];
3'b110: out=E&I[6];
3'b111: out=E&I[7];
endcase
end
endmodule

module mux_tb;

reg [2:0]S;
reg E;
reg [7:0]I;
wire out;
mux ans(S,E,I,out);
initial begin
$dumpfile ("mux.vcd");
$dumpvars;
S=0;
E=1;
I=1;
#5;
$display("S=%d, E=%d, I=%d, Out=%d",S,E,I,out);
S=1;
E=1;
I=2;
#5;
$display("S=%d, E=%d, I=%d, Out=%d",S,E,I,out);
S=2;
E=1;
I=4;
#5;
$display("S=%d, E=%d, I=%d, Out=%d",S,E,I,out);
S=3;
E=1;
I=8;
#5;
$display("S=%d, E=%d, I=%d, Out=%d",S,E,I,out);
S=4;
E=1;
I=16;
#5;
$display("S=%d, E=%d, I=%d, Out=%d",S,E,I,out);
S=5;
E=1;
I=32;
#5;
$display("S=%d, E=%d, I=%d, Out=%d",S,E,I,out);
S=6;
E=1;
I=64;
#5;
$display("S=%d, E=%d, I=%d, Out=%d",S,E,I,out);
S=7;
E=1;
I=128;
#5;
$display("S=%d, E=%d, I=%d, Out=%d",S,E,I,out);

S=6;
E=0;
I=64;
#5;
$display("S=%d, E=%d, I=%d, Out=%d",S,E,I,out);
S=7;
E=0;
I=128;
#5;
$display("S=%d, E=%d, I=%d, Out=%d",S,E,I,out);
$finish();
end

endmodule