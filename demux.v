module demux1to4(input data, input [1:0] s, output reg data_out0, data_out1, data_out2, data_out3);
    always @(s, data) begin
        case(s)
            0: begin
                data_out0 = data;
                data_out1 = 1'b0;
                data_out2 = 1'b0;
                data_out3 = 1'b0;
            end
            1: begin
                data_out1 = data;
                data_out0 = 1'b0;
                data_out2 = 1'b0;
                data_out3 = 1'b0;
            end
            2: begin
                data_out2 = data;
                data_out1 = 1'b0;
                data_out0 = 1'b0;
                data_out3 = 1'b0;
            end
            3: begin
                data_out3 = data;
                data_out1 = 1'b0;
                data_out2 = 1'b0;
                data_out0 = 1'b0;
            end
        endcase
    end 
endmodule

module de2mux1to4(input data, input [1:0] s, output data_out0, data_out1, data_out2, data_out3);
    wire [1:0] not_s;
    not not1(not_s[0], s[0]);
    not not2(not_s[1], s[1]);
    and and1(data_out0, data, not_s[0], not_s[1]);
    and and2(data_out1, data, s[0], not_s[1]);
    and and3(data_out2, data, not_s[0], s[1]);
    and and4(data_out3, data, s[0], s[1]);
endmodule

module de1mux1to4(input data, input [1:0] s, output reg data_out0, data_out1, data_out2, data_out3);
    always @(s, data) begin
    if(s==0)
        begin
            data_out0 = data;
            data_out1 = 1'b0;
            data_out2 = 1'b0;
            data_out3 = 1'b0;
        end
    else if(s==1)
        begin
            data_out1 = data;
            data_out0 = 1'b0;
            data_out2 = 1'b0;
            data_out3 = 1'b0;
        end
    else if(s==2)
        begin
            data_out2 = data;
            data_out1 = 1'b0;
            data_out0 = 1'b0;
            data_out3 = 1'b0;
        end
    else if(s==3)
        begin
            data_out3 = data;
            data_out1 = 1'b0;
            data_out2 = 1'b0;
            data_out0 = 1'b0;
        end
    end
endmodule

module demux1to2(input data, input s, output reg data0, data1);
    always @(data,s) begin
        case(s)
            0: begin
                data0 = data;
                data1 = 0;
            end
            1: begin
                data0 = 0;
                data1 = data;
            end
        endcase
    end
endmodule

module demux1to8(input data, input[2:0] s, output [7:0] data_out);
    wire data0, data1;
    demux1to2 dmx1(data, s[2], data0, data1);
    demux1to4 dmx2(data0, s[1:0], data_out[0], data_out[1], data_out[2], data_out[3]);
    demux1to4 dmx3(data1, s[1:0], data_out[4], data_out[5], data_out[6], data_out[7]);
endmodule

// module demux_tb();
//     wire data0, data1, data2, data3;
//     reg data;
//     reg [1:0] select;
//     de2mux1to4 dmx(data, select, data0, data1, data2, data3);
//     initial begin
//         $display("Structural: ")
//         data = 1;

//         select = 0; #10;
//         $display("Data: %b, Select: %b, Out: %b %b %b %b", data, select, data3, data2, data1, data0);
//         select = 1; #10;
//         $display("Data: %b, Select: %b, Out: %b %b %b %b", data, select, data3, data2, data1, data0);
//         select = 2; #10;
//         $display("Data: %b, Select: %b, Out: %b %b %b %b", data, select, data3, data2, data1, data0);
//         select = 3; #10;
//         $display("Data: %b, Select: %b, Out: %b %b %b %b", data, select, data3, data2, data1, data0);
//     end
// endmodule
module demux_testbench();
    reg data;
    reg [2:0] select;
    wire [7:0] data_out;
    demux1to8 dem(data, select, data_out);
    initial begin
        $dumpfile("dem.vcd");
        $dumpvars(0,demux_testbench);
        $display("Behavioral: ");
        data = 1;

        select = 0; #10;
        $display("Data: %b, Select: %b, Out: %b %b %b %b %b %b %b %b", data, select, data_out[7], data_out[6], data_out[5], data_out[4], data_out[3], data_out[2], data_out[1], data_out[0],);
        select = 1; #10;
        $display("Data: %b, Select: %b, Out: %b %b %b %b %b %b %b %b", data, select, data_out[7], data_out[6], data_out[5], data_out[4], data_out[3], data_out[2], data_out[1], data_out[0],);
        select = 2; #10;
        $display("Data: %b, Select: %b, Out: %b %b %b %b %b %b %b %b", data, select, data_out[7], data_out[6], data_out[5], data_out[4], data_out[3], data_out[2], data_out[1], data_out[0],);
        select = 3; #10;
        $display("Data: %b, Select: %b, Out: %b %b %b %b %b %b %b %b", data, select, data_out[7], data_out[6], data_out[5], data_out[4], data_out[3], data_out[2], data_out[1], data_out[0],);
        select = 4; #10;
        $display("Data: %b, Select: %b, Out: %b %b %b %b %b %b %b %b", data, select, data_out[7], data_out[6], data_out[5], data_out[4], data_out[3], data_out[2], data_out[1], data_out[0],);
        select = 5; #10;
        $display("Data: %b, Select: %b, Out: %b %b %b %b %b %b %b %b", data, select, data_out[7], data_out[6], data_out[5], data_out[4], data_out[3], data_out[2], data_out[1], data_out[0],);
        select = 6; #10;
        $display("Data: %b, Select: %b, Out: %b %b %b %b %b %b %b %b", data, select, data_out[7], data_out[6], data_out[5], data_out[4], data_out[3], data_out[2], data_out[1], data_out[0],);
        select = 7; #10;
        $display("Data: %b, Select: %b, Out: %b %b %b %b %b %b %b %b", data, select, data_out[7], data_out[6], data_out[5], data_out[4], data_out[3], data_out[2], data_out[1], data_out[0],);

        $finish;
    end
endmodule