module priority_encoder(input [7:0]A,output [2:0] out);
    reg out;
  always @(*) begin
    if (A[7]) begin
      out <= 3'b111;
    end else if (A[6]) begin
      out <= 3'b110;
    end else if (A[5]) begin
      out <= 3'b101;
    end else if (A[4]) begin
      out <= 3'b100;
    end else if (A[3]) begin
      out <= 3'b011;
    end else if (A[2]) begin
      out <= 3'b010;
    end else if (A[1]) begin
      out <= 3'b001;
    end else begin
      out <= 3'b000;
    end
  end

endmodule


module priority_encoder_tb;

reg [7:0]A;
wire [2:0]out;
priority_encoder ans(A,out);
initial begin
$dumpfile ("priority_encoder.vcd");
$dumpvars;
A=1;
#5;
$display("A=%d, Out=%d",A,out);
A=2;
#5;
$display("A=%d, Out=%d",A,out);
A=4;
#5;
$display("A=%d, Out=%d",A,out);
A=8;
#5;
$display("A=%d, Out=%d",A,out);
A=16;
#5;
$display("A=%d, Out=%d",A,out);
A=32;
#5;
$display("A=%d, Out=%d",A,out);
A=64;
#5;
$display("A=%d, Out=%d",A,out);
A=130;
#5;
$display("A=%d, Out=%d",A,out);
$finish();
end

endmodule