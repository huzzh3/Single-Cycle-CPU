`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 23:37:24
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input clk,//ע�������д�ź�ͬ������Ҫʱ���������ģ�����Ҫʱ���ź�
    input [31:0] Address, //32λ�����ݵ�ַ
    input [31:0] WriteData, //Ҫд�������
    input MemRead, //���ź�
    input MemWrite, //д�ź�
    output [31:0] ReadData //����������
    );
    reg [7:0] memoryRAM [0:47]; //������InstructionMemory�еĶ���һ��������Ҳ��һ���֣���8λΪһ���洢��Ԫ��һ����48���洢��Ԫ(������������ָĴ��ͺ���)
    integer i;
    initial begin//����Ԥ������
        for(i = 0; i <= 47; i = i + 1) memoryRAM[i] = 0; //��ʼ�����ǳ���Ҫ����ֹ����
        
        memoryRAM[4] = 8'h00;
        memoryRAM[5] = 8'h00;
        memoryRAM[6] = 8'h00;
        memoryRAM[7] = 8'h06;
        memoryRAM[8] = 8'h00;
        memoryRAM[9] = 8'h00;
        memoryRAM[10] = 8'h00;
        memoryRAM[11] = 8'h09;
    end
    assign ReadData[31:24] = (MemRead == 1) ? memoryRAM[Address+0] : 8'bz; //���û��д�źţ���ô�Ͱ���32λȫ������Ϊz������ȷ����ƽ
    assign ReadData[23:16] = (MemRead == 1) ? memoryRAM[Address+1] : 8'bz;
    assign ReadData[15:8]  = (MemRead == 1) ? memoryRAM[Address+2] : 8'bz;
    assign ReadData[7:0]   = (MemRead == 1) ? memoryRAM[Address+3] : 8'bz;
    
    always @(posedge clk) begin
        //��ʱ��������д��
        if (MemWrite == 1) begin
            memoryRAM[Address+0] <= WriteData[31:24];
            memoryRAM[Address+1] <= WriteData[23:16];
            memoryRAM[Address+2] <= WriteData[15:8];
            memoryRAM[Address+3] <= WriteData[7:0];
        end
    end 
endmodule

