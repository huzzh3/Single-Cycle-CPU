`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 23:39:21
// Design Name: 
// Module Name: CPUTOP
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


module CPUTOP(
    input clk,
    output [15:0] q,
    output [31:0] data0,
    output [31:0] data1,
    output [31:0] data2,
    output [31:0] data3,
    output [31:0] data4,
    output [31:0] data5,
    output [31:0] data6,
    output [31:0] data7
   );
   
   wire [31:0] currentPC;
   wire [31:0] Instruction;
   wire RegDst; //����Mux(1)ѡrd
   wire Jump; //��תָ��
   wire Branch; //��ָ֧��
   wire MemRead; //���ڴ�ָ��
   wire MemtoReg; //д��Ĵ���ָ�����lw
   wire [2:0] ALUOp; //����ALUControl
   wire MemWrite; //д�ڴ�ָ�����Data memory
   wire ALUSrc; //����Mux(2)ѡReadData2���Ƿ�����չ֮�����
   wire RegWrite; //�Ĵ���д�ź�
   wire [31:0] WriteData; //Ҫ��д�������
   wire [4:0] WriteRegister; //Ҫд��ļĴ���
   wire [31:0] ReadData1; //�����ĵ�һ����
   wire [31:0] ReadData2; //�����ĵڶ�����
   wire [31:0] extendedData; //������չ֮�����
   wire [31:0] ALUInputData2; //ALU�ĵڶ������
   wire [3:0] ALUControlSingal; //ALU�����ź�
   wire zero;
   wire [31:0] ReadData;//Data memory ����������
   wire [31:0] currentPCAdd4 = currentPC + 4;
   wire [31:0] nextPC;
   wire [31:0] ALUResult;
   
   
   assign nextPC = (Jump) ? {currentPCAdd4[31:28], Instruction[25:0], 2'b00} : //�ⲿ������ʵ��Jump��beq����ת
                   (Branch && zero) ? currentPCAdd4+(extendedData<<2) : 
                   (Instruction[5:0] == 6'b001000 && Instruction[31:26] == 6'b000000 ? ALUResult : currentPCAdd4);
    //����������޸ģ�������jr��䣬�����jr���Ļ�����ôֱ����ALUResult�Ľ����Ϊ��һ��PC����ת�ͺ���
   
   assign WriteRegister = RegDst ? Instruction[15:11] : 
                         (Jump == 0 ? Instruction[20:16] : 
                         (RegWrite == 1 ? 5'b11111 : 0)); 
   //����������޸ģ����RegDst==0��ʱ��Ҫ�ж���û����ת�źţ����û�еĻ�˵������jal��j��䣬�еĻ���˵����jal��j��䣬֮�����ж���û��д�Ĵ����źţ��еĻ�˵����jal��䣬û�еĻ�˵����j���
   assign ALUInputData2 = ALUSrc ? extendedData : ReadData2; //Mux(2)
   assign WriteData = MemtoReg ? ReadData : 
                      (Jump == 0 ? ALUResult : 
                      (RegWrite == 1 ? currentPCAdd4 : 0));
   //ͬ��������������޸ģ������jal���Ļ�����д���������currentPC+4
   
   assign q = {WriteData[7:0],currentPC[7:0]};
       
   PC uPC(clk, nextPC, currentPC);
   InstructionMemory uInstructionMemory(currentPC, Instruction);
   ControlUnit uControlUnit(Instruction[31:26], RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
   Registers uRegisters(clk, RegWrite, Instruction[25:21], Instruction[20:16], WriteRegister, WriteData, ReadData1, ReadData2);
   SignExtend uSignExtend(Instruction[15:0], extendedData);
   ALUControl uALUControl(ALUOp, Instruction[5:0],ALUControlSingal);
   ALU uALU(Instruction[10:6], ALUControlSingal,ReadData1, ALUInputData2, zero, ALUResult);
   DataMemory uDataMemory(clk, ALUResult, ReadData2, MemRead, MemWrite, ReadData, data0, data1, data2, data3, data4, data5, data6, data7);
   
endmodule
