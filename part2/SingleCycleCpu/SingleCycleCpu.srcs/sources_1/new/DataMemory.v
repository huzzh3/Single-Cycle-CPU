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
    output [31:0] ReadData, //����������
    
    output [31:0] data0, //�����������ĵ�������ݣ���Ϊ�ӿڣ����ں����д��
    output [31:0] data1,
    output [31:0] data2,
    output [31:0] data3,
    output [31:0] data4,
    output [31:0] data5,
    output [31:0] data6,
    output [31:0] data7
    );
    reg [7:0] memoryRAM [0:47]; //������InstructionMemory�еĶ���һ��������Ҳ��һ���֣���8λΪһ���洢��Ԫ��һ����48���洢��Ԫ(������������ָĴ��ͺ���)
    integer i;
    initial begin//����Ԥ������
        for(i = 0; i <= 47; i = i + 1) memoryRAM[i] = 0; //��ʼ�����ǳ���Ҫ����ֹ����
        
        memoryRAM[0] = 8'h00; //����5
        memoryRAM[1] = 8'h00;
        memoryRAM[2] = 8'h00;
        memoryRAM[3] = 8'h05;
        
        memoryRAM[4] = 8'h00; //����20
        memoryRAM[5] = 8'h00;
        memoryRAM[6] = 8'h00;
        memoryRAM[7] = 8'h20;
        
        memoryRAM[8] = 8'h00; //����15
        memoryRAM[9] = 8'h00;
        memoryRAM[10] = 8'h00;
        memoryRAM[11] = 8'h15;
        
        memoryRAM[12] = 8'h00; //����12
        memoryRAM[13] = 8'h00;
        memoryRAM[14] = 8'h00;
        memoryRAM[15] = 8'h12;
        
        memoryRAM[16] = 8'h00;//����36
        memoryRAM[17] = 8'h00;
        memoryRAM[18] = 8'h00;
        memoryRAM[19] = 8'h36;
        
        memoryRAM[20] = 8'h00;//����45
        memoryRAM[21] = 8'h00;
        memoryRAM[22] = 8'h00;
        memoryRAM[23] = 8'h45;
        
        memoryRAM[24] = 8'h00;//����47
        memoryRAM[25] = 8'h00;
        memoryRAM[26] = 8'h00;
        memoryRAM[27] = 8'h47;
        
        memoryRAM[28] = 8'h00;//����18
        memoryRAM[29] = 8'h00;
        memoryRAM[30] = 8'h00;
        memoryRAM[31] = 8'h18;
        
    end
    assign ReadData[31:24] = (MemRead == 1) ? memoryRAM[Address+0] : 8'bz; //���û��д�źţ���ô�Ͱ���32λȫ������Ϊz������ȷ����ƽ
    assign ReadData[23:16] = (MemRead == 1) ? memoryRAM[Address+1] : 8'bz;
    assign ReadData[15:8]  = (MemRead == 1) ? memoryRAM[Address+2] : 8'bz;
    assign ReadData[7:0]   = (MemRead == 1) ? memoryRAM[Address+3] : 8'bz;
    
    assign data0 = {memoryRAM[0],memoryRAM[1],memoryRAM[2],memoryRAM[3]};
    assign data1 = {memoryRAM[4],memoryRAM[5],memoryRAM[6],memoryRAM[7]};
    assign data2 = {memoryRAM[8],memoryRAM[9],memoryRAM[10],memoryRAM[11]};
    assign data3 = {memoryRAM[12],memoryRAM[13],memoryRAM[14],memoryRAM[15]};
    assign data4 = {memoryRAM[16],memoryRAM[17],memoryRAM[18],memoryRAM[19]};
    assign data5 = {memoryRAM[20],memoryRAM[21],memoryRAM[22],memoryRAM[23]};
    assign data6 = {memoryRAM[24],memoryRAM[25],memoryRAM[26],memoryRAM[27]};
    assign data7 = {memoryRAM[28],memoryRAM[29],memoryRAM[30],memoryRAM[31]};
    
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

