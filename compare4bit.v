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

module xnor_g(input a,b,
           output d);

    wire a_not, b_not, x, y, c;

    not a_inv(a_not, a);
    not b_inv(b_not, b);
    and a1(x, a_not, b);
    and a2(y, b_not, a);

    or out(c, x, y);
    
    not g3(d, c);

endmodule

module compare4bit(input a0, a1, a2, a3, b0, b1, b2, b3,
                    output aGrtb, aEqb, aLessb );

                    wire grtn0, grtn1, grtn2, grtn3;
                    wire grtn11, grtn01;
                    wire eqn0, eqn1, eqn2, eqn3;//xnor/equality also goes in other and gates.
                    wire lessn0, lessn1, lessn2, lessn3;
                    wire lessn11, lessn01;
                    wire eq_and_inter;
                    wire grtOrinter;
                    wire lessOrinter;


                            not g0(na0, a0);
                            not g1(na1, a1);
                            not g2(na2, a2);
                            not g3(na3, a3);

                            not g4(nb0, b0);
                            not g5(nb1, b1);
                            not g6(nb2, b2);
                            not g7(nb3, b3);

                            xnor_g eq_z3(a3, b3, eqn3);
                            xnor_g eq_z2(a2, b2, eqn2);
                            xnor_g eq_z1(a1, b1, eqn1);
                            xnor_g eq_z0(a0, b0, eqn0);

                            and grt_a3(grtn3, a3, nb3);
                            and3 grt_a2(a2, nb2, eqn3, grtn2);
                            and3 grt_inter_a1(a1, nb1, eqn3, grtn11);
                            and grt_a1(grtn1, grtn11 , eqn2);
                            and3 grt_inter_a0(a0, nb0, eqn3, grtn01);
                            and3 grt_a0(grtn01, eqn2, eqn1, grtn0);

                            and less_a3(lessn3, na3, b3);
                            and3 less_a2(na2, b2, eqn3, lessn2);
                            and3 less_inter_a1(na1, b1, eqn3, lessn11);
                            and less_a1(lessn1, lessn11 , eqn2);
                            and3 less_inter_a0(na0, b0, eqn3, lessn01);
                            and3 less_a0(lessn01, eqn2, eqn1, lessn0);

                            and3 aEqualb_inter(eqn3, eqn2, eqn1, eq_and_inter);
                            and aEqualb(aEqb, eq_and_inter, eqn0);

                            or3 aGrtb_inter(grtn3, grtn2, grtn1, grtOrinter);
                            or aGreaterb(aGrtb, grtOrinter, grtn0);

                            or3 aLessb_inter(lessn3, lessn2, lessn1, lessOrinter);
                            or aLesserb(aLessb, lessOrinter, lessn0);

endmodule

module compare4bit_tb();

reg a0, a1, a2, a3, b0, b1, b2, b3;
wire aGrtb, aEqb, aLessb;

compare4bit c4_bit(a0, a1, a2, a3, b0, b1, b2, b3, aGrtb, aEqb, aLessb);

initial begin
            
        $dumpfile("compare4bit_tb.vcd");
        $dumpvars(0, compare4bit_tb);

        a0 = 1'b0; a1 = 1'b1; a2 = 1'b0; a3 = 1'b0; b0 = 1'b0; b1 = 1'b1; b2 = 1'b0; b3 = 1'b0; #10;
        $display("a0 = %b, a1 = %b, a2 = %b, a3 = %b, b0 = %b, b1 = %b, b2 = %b, b3 = %b, aGrtb = %b, aEqb = %b, aLessb = %b", a0, a1, a2, a3, b0, b1, b2, b3, aGrtb, aEqb, aLessb);

        a0 = 1'b0; a1 = 1'b0; a2 = 1'b0; a3 = 1'b1; b0 = 1'b0; b1 = 1'b1; b2 = 1'b0; b3 = 1'b0; #10;
        $display("a0 = %b, a1 = %b, a2 = %b, a3 = %b, b0 = %b, b1 = %b, b2 = %b, b3 = %b, aGrtb = %b, aEqb = %b, aLessb = %b", a0, a1, a2, a3, b0, b1, b2, b3, aGrtb, aEqb, aLessb);

        a0 = 1'b1; a1 = 1'b0; a2 = 1'b0; a3 = 1'b0; b0 = 1'b0; b1 = 1'b1; b2 = 1'b0; b3 = 1'b0; #10;
        $display("a0 = %b, a1 = %b, a2 = %b, a3 = %b, b0 = %b, b1 = %b, b2 = %b, b3 = %b, aGrtb = %b, aEqb = %b, aLessb = %b", a0, a1, a2, a3, b0, b1, b2, b3, aGrtb, aEqb, aLessb);


end
endmodule