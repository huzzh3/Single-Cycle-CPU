`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/27 11:38:10
// Design Name: 
// Module Name: smg
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


module smg(
    input clk,
    input [3:0] hex0,
    input [3:0] hex1,
    input [3:0] hex2,
    input [3:0] hex3,
    output reg [3:0] enable, //使能信号，告诉电路板让哪个LED灯亮
    output [7:0] segmentCode //输出对应的七段数码馆
    );
    
    wire div_clk;//分频后的时钟信号
    wire [1:0] count; //用于counter4
    wire [3:0] outputHex; //用于接收Mux选出的16进制数
    
    always @(count) begin
        case(count)
            2'b00: enable = 4'b1110; //亮第一个LED
            2'b01: enable = 4'b1101; //亮第二个LED
            2'b10: enable = 4'b1011; //亮第三个LED
            2'b11: enable = 4'b0111; //亮第四个LED
        endcase
    end
    
    clkDiv uclkDiv(clk, div_clk);
    counter4 ucounter4(div_clk, count);
    smgMux usmgMux(count, hex0, hex1, hex2, hex3, outputHex);
    HexToSeg uHexToSeg(outputHex, segmentCode);
endmodule
