`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 23:33:17
// Design Name: 
// Module Name: PC
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


module PC(
	input clk,
	input[31:0] nextPC,
	output reg[31:0] currentPC
);
//��ʦ�������ǰ�jump��beq����ת���ϵ���PCģ�����ѡ��jump��beq����ת���ϵ������ļ���
	initial begin
		currentPC =	0;
	end
	always@(posedge clk)begin
		currentPC =	nextPC;
	end
endmodule
