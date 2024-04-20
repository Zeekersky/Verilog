module priority_encoder(input [7:0] data, output reg [2:0] res);
    always @(*) begin
        if (data[7] == 1'b1)
            res <= 7;
        else if (data[6] == 1'b1)
            res <= 6;
        else if (data[5] == 1'b1)
            res <= 5;
        else if (data[4] == 1'b1)
            res <= 4;
        else if (data[3] == 1'b1)
            res <= 3;
        else if (data[2] == 1'b1)
            res <= 2;
        else if (data[1] == 1'b1)
            res <= 1;
        else if (data[0] == 1'b1)
            res <= 0;
    end
endmodule

module priority_encoder_testbench();
    reg [7:0] data;
    wire [2:0] res;
    priority_encoder priority_encoder_inst (data, res);
    initial begin
        $dumpfile("priority_encoder_testbench.vcd");
        $dumpvars(0, priority_encoder_testbench);
        data = 8'b00000001; #10;
        $display("data = %b, res = %b", data, res);
        data = 8'b00000011; #10;
        $display("data = %b, res = %b", data, res);
        data = 8'b00000101; #10;
        $display("data = %b, res = %b", data, res);
        data = 8'b00001101; #10;
        $display("data = %b, res = %b", data, res);
        data = 8'b00010100; #10;
        $display("data = %b, res = %b", data, res);
        data = 8'b00111010; #10;
        $display("data = %b, res = %b", data, res);
        data = 8'b01100010; #10;
        $display("data = %b, res = %b", data, res);
        data = 8'b11111111; #10;
        $display("data = %b, res = %b", data, res);
        $finish;
    end
endmodule