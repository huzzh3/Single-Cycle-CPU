`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 23:35:49
// Design Name: 
// Module Name: Registers
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


module Registers(
    input clk, //ע��writeRegister��ͨ��ʱ���ź�������д�źŵģ�������Ҫ����ʱ���ź������writeRegister
    input regWrite, //�Ĵ���д�ź�
    input [4:0] ReadRegister1,
    input [4:0] ReadRegister2,
    input [4:0] WriteRegister,
    input [31:0] WriteData,
    output [31:0] ReadData1,
    output [31:0] ReadData2
    );
    reg [31:0] registerFile [1:31]; //����$1~$31�ļĴ�����$0��$zero���ʱ�������λ�ã���ֹ���޸ģ�ÿ���Ĵ�������32λ����Ϊ[31:0]
    integer i;
    initial begin
        for (i = 1; i <= 31; i = i + 1) registerFile[i] = 0;//��ʼ���Ĵ�����
        
        registerFile[5] = 32'h00000008;     //��ʼ��$a1λΪ8��Ҳ����Ҫ��������鳤��Ϊ8
    end
    assign ReadData1 = (ReadRegister1 == 4'b0000) ? 0 : registerFile[ReadRegister1];  //����ReadRegister1 == 4'b0000��仰����Ϊ�˸�$0�Ĵ��������
    assign ReadData2 = (ReadRegister2 == 4'b0000) ? 0 : registerFile[ReadRegister2];
    always @(posedge clk) begin
        if (regWrite == 1 && WriteRegister != 4'b0000)  //����Ĵ�������д�źŲ���д��Ĳ���$0�Ĵ���($0��0���ܱ��޸�)������Ҫд��Ĵ���
            registerFile[WriteRegister] <= WriteData;
    end
endmodule

