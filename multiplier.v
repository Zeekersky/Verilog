module and3(input d0, d1, d2,
			output y);

  wire n1;
  and g1(n1, d0, d1);
  and g2(y, n1,d2);

endmodule

module or3(input d0, d1, d2,
			output y);

  wire n1;
  or g1(n1, d0, d1);
  or g2(y, n1,d2);

endmodule

module xor_g(input a,b,
           output c);

    wire a_not, b_not, x, y;

    not a_inv(a_not, a);
    not b_inv(b_not, b);
    and a1(x, a_not, b);
    and a2(y, b_not, a);

    or out(c, x, y);

endmodule

module mux4_1(input i0, i1, i2, i3, s0, s1,
              output y);

    wire ns0, ns1, i0_n0, i1_n1, i2_n2, i3_n3, or_n4;

    not g1(ns0, s0);
    not g2(ns1, s1);
    and3 g3_0(i0, ns0, ns1, i0_n0);
    and3 g4_1(i1, ns0, s1, i1_n1);
    and3 g5_2(i2, s0, ns1, i2_n2);
    and3 g6_3(i3, s0, s1, i3_n3);
    or3 g7(i0_n0, i1_n1, i2_n2, or_n4);
    or g8(y, or_n4, i3_n3);
    
endmodule

module halfAdd(input a, b,
                output sum,
                output c_out);

xor_g xg(a, b, sum);

and g1(c_out, a, b);

                
endmodule

module fullAdd(
  input a, b, c_in, 
  output sum, c_out  
);

wire h_n1, n2, h_n3;

halfAdd h_g1(a, b, h_n1, n2);

halfAdd h_g2(c_in, h_n1, sum, h_n3);

or g3(c_out, h_n3, n2);

endmodule

module halfSubtrac(input a, b,
                output sum,
                output b_out);

wire n1;

xor_g xg(a, b, sum);

not h1(n1, a);

and g1(b_out, n1, b);

                
endmodule

module fullSubtrac(
  input a, b, b_in, 
  output d, b_out  
);

wire h1_n1, h1_n2, h2_n3;

halfSubtrac h_g1(a, b, h1_n1, h1_n2);
halfSubtrac h_g2(h1_n1, b_in, d, h2_n3);
or g3(b_out, h2_n3, h1_n2);

endmodule

module mux(input [3:0] a, b, output[7:0] p);
                  wire n00, n01, n02, n10, n11, n12, n13, n20, n21, n22, n23, n30, n31, n32, n33;
                  wire c11_1, c11_2, c11_3, c11_4_21, c21_1, c21_2, c21_3, c21_4_31, c31_1, c31_2, c31_3;
                  wire s11_211, s11_212, s11_213, s21_311, s21_312, s21_313;
                  and a00(p[0], a[0], b[0]);
                  and a01(n00, a[1], b[0]);
                  and a02(n01, a[2], b[0]);
                  and a03(n02, a[3], b[0]);
                  and a10(n10, a[0], b[1]);
                  and a11(n11, a[1], b[1]);
                  and a12(n12, a[2], b[1]);
                  and a13(n13, a[3], b[1]);
                  halfAdd ha011(n00, n10, p[1], c11_1);
                  fullAdd fa111(n01, n10, c11_1, s11_211, c11_2);
                  fullAdd fa211(n02, n12, c11_2, s11_212, c11_3);
                  halfAdd ha311(n13, c11_3, s11_213, c11_4_21);
                  and a20(n20, a[0], b[2]);
                  and a21(n21, a[1], b[2]);
                  and a22(n22, a[2], b[2]);
                  and a23(n23, a[3], b[2]);
                  halfAdd ha021(n20, s11_211, p[2], c21_1);
                  fullAdd fa121(n21, s11_212, c21_1, s21_311, c21_2);
                  fullAdd fa221(n22, s11_213, c21_2, s21_312, c21_3);
                  fullAdd fa321(n23, c11_4_21, c21_3, s21_313, c21_4_31);
                  and a30(n30, a[0], b[3]);
                  and a31(n31, a[1], b[3]);
                  and a32(n32, a[2], b[3]);
                  and a33(n33, a[3], b[3]);
                  halfAdd ha031(n30, s21_311, p[3], c31_1);
                  fullAdd fa131(n31, s21_312, c31_1, p[4], c31_2);
                  fullAdd fa231(n32, s21_313, c31_2, p[5], c31_3);
                  fullAdd fa331(n33, c21_4_31, c31_3, p[6], p[7]);

endmodule

module muux_tb();
    reg [3:0] a;
    reg [3:0] b;
    wire [7:0] c;
    multiplier mux (a,b,c);

    initial begin
        a = 2; b = 2;
        #10;
        $display("Input a = %b, b = %b, Output %b",a,b,c);
    end
endmodule