`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/02 00:59:06
// Design Name: 
// Module Name: dataSelect
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dataSelect( //用来选择CPUTOP输出的8个数据中的一个，然后传给段码转化模块
    input clk,
    input [31:0] data0,
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] data3,
    input [31:0] data4,
    input [31:0] data5,
    input [31:0] data6,
    input [31:0] data7,
    output reg [31:0] selectData = 0
    );
    reg [2:0] count = 0;
    always @(posedge clk) begin
        if(count == 3'b111) count <= 0;
        else count <= count + 1;
        
        case(count)
            3'b000: selectData <= data0;
            3'b001: selectData <= data1;
            3'b010: selectData <= data2;
            3'b011: selectData <= data3;
            3'b100: selectData <= data4;
            3'b101: selectData <= data5;
            3'b110: selectData <= data6;
            3'b111: selectData <= data7;
        endcase
    end
endmodule
