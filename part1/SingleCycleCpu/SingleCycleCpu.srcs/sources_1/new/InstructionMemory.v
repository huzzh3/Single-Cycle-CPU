`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 23:33:52
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory(
    input [31:0] currentPC,
    output [31:0] instruction
    );
    reg [7:0] memoryROM [0:47]; //˵��һ�£�����һ���洢��Ԫ��8λ��һ��ָ��32λ������Ҫ�ĸ��洢��Ԫ��֮��һ����12��ָ�����Ҫ48���洢��Ԫ
    initial begin //д�뷭��õĻ�����
        $readmemb("D:/vivadoProject/CPUSingleCycle/CPUSingleCycle.srcs/sources_1/new/data.txt", memoryROM);//���븴�ֵĻ�����Ҫ�޸�����ľ��Ե�ַ
    end
    //ͨ��currentPC���ĸ��ڴ�ռ�����ݺϲ���һ��ָ��
    assign instruction[31:24] = memoryROM[currentPC+0];
    assign instruction[23:16] = memoryROM[currentPC+1];
    assign instruction[15:8]  = memoryROM[currentPC+2];
    assign instruction[7:0]   = memoryROM[currentPC+3];
endmodule

