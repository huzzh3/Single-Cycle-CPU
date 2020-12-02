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
//老师的做法是把jump和beq的跳转整合到了PC模块里，我选择将jump和beq的跳转整合到顶层文件上
	initial begin
		currentPC =	0;
	end
	always@(posedge clk)begin
		currentPC =	nextPC;
	end
endmodule
