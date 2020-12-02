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
    input [2:0] ALUOp,//PPT��д������λ��ʵ����Ҫ�ĳ���λ
    input [5:0] funct,//R��ʽ��funct
    output reg [3:0] ALUControlSingal //��λ�Ŀ����źţ����ڸ���ALUҪִ��ʲôָ��
    );
    initial  ALUControlSingal = 0;
    always @(ALUOp or funct) begin
        casex({ALUOp, funct}) //����ƴ����һ�𣬷����жϣ�ע��Ҫ��casx��Ϊfunct����Ϊxxxxxx
            9'b000xxxxxx: ALUControlSingal = 4'b0010;//�����ź����Ϊ�ӷ�
            9'b001xxxxxx: ALUControlSingal = 4'b0110;//�����ź����Ϊ����
            9'b010100000: ALUControlSingal = 4'b0010;//R��ʽָ��ͨ��funct���жϣ���������ӷ�
            9'b010100010: ALUControlSingal = 4'b0110;//�������
            9'b010100100: ALUControlSingal = 4'b0000;//���AND�ź�
            9'b010100101: ALUControlSingal = 4'b0001;//���OR�ź�
            9'b010101010: ALUControlSingal = 4'b0111;//���set-on-less-than�ź�
        endcase
    end
    
endmodule