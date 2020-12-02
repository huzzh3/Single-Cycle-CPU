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
    output reg [3:0] enable, //ʹ���źţ����ߵ�·�����ĸ�LED����
    output [7:0] segmentCode //�����Ӧ���߶������
    );
    
    wire div_clk;//��Ƶ���ʱ���ź�
    wire [1:0] count; //����counter4
    wire [3:0] outputHex; //���ڽ���Muxѡ����16������
    
    always @(count) begin
        case(count)
            2'b00: enable = 4'b1110; //����һ��LED
            2'b01: enable = 4'b1101; //���ڶ���LED
            2'b10: enable = 4'b1011; //��������LED
            2'b11: enable = 4'b0111; //�����ĸ�LED
        endcase
    end
    
    clkDiv uclkDiv(clk, div_clk);
    counter4 ucounter4(div_clk, count);
    smgMux usmgMux(count, hex0, hex1, hex2, hex3, outputHex);
    HexToSeg uHexToSeg(outputHex, segmentCode);
endmodule
