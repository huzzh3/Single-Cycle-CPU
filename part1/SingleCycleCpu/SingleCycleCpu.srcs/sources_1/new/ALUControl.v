`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 23:38:30
// Design Name: 
// Module Name: ALUControl
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


module ALUControl(
    input [2:0] ALUOp,//PPT中写的是两位，实际上要改成三位
    input [5:0] funct,//R格式的funct
    output reg [3:0] ALUControlSingal //四位的控制信号，用于告诉ALU要执行什么指令
    );
    initial  ALUControlSingal = 0;
    always @(ALUOp or funct) begin
        casex({ALUOp, funct}) //将其拼接在一起，方便判断，注意要用casx因为funct可以为xxxxxx
            9'b000xxxxxx: ALUControlSingal = 4'b0010;//控制信号输出为加法
            9'b001xxxxxx: ALUControlSingal = 4'b0110;//控制信号输出为减法
            9'b010100000: ALUControlSingal = 4'b0010;//R格式指令通过funct来判断，这里输出加法
            9'b010100010: ALUControlSingal = 4'b0110;//输出减法
            9'b010100100: ALUControlSingal = 4'b0000;//输出AND信号
            9'b010100101: ALUControlSingal = 4'b0001;//输出OR信号
            9'b010101010: ALUControlSingal = 4'b0111;//输出set-on-less-than信号
        endcase
    end
    
endmodule