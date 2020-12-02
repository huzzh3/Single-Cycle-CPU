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
    output [15:0] q
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
   wire [31:0] ALUResult;
   wire [31:0] ReadData;//Data memory ����������
   wire [31:0] nextPC;
   wire [31:0] currentPCAdd4 = currentPC + 4;
   
   assign nextPC = (Jump) ? {currentPCAdd4[31:28], Instruction[25:0], 2'b00} : //�ⲿ������ʵ��Jump��beq����ת
                   (Branch && zero) ? currentPCAdd4+(extendedData<<2) : currentPCAdd4;
   
   assign WriteRegister = RegDst ? Instruction[15:11] : Instruction[20:16]; //Mux(1)�Ĺ��ܣ�������ʹ���������ʵ�֣�Ϊ�˷��㣬�Ͳ�Ҫ��дһ��ģ����
   assign ALUInputData2 = ALUSrc ? extendedData : ReadData2; //Mux(2)
   assign WriteData = MemtoReg ? ReadData : ALUResult; //Mux(3)
   
   assign q = {WriteData[7:0],currentPC[7:0]};
       
   PC uPC(clk, nextPC, currentPC);
   InstructionMemory uInstructionMemory(currentPC, Instruction);
   ControlUnit uControlUnit(Instruction[31:26], RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
   Registers uRegisters(clk, RegWrite, Instruction[25:21], Instruction[20:16], WriteRegister, WriteData, ReadData1, ReadData2);
   SignExtend uSignExtend(Instruction[15:0], extendedData);
   ALUControl uALUControl(ALUOp, Instruction[5:0],ALUControlSingal);
   ALU uALU(ALUControlSingal,ReadData1, ALUInputData2, zero, ALUResult);
   DataMemory uDataMemory(clk, ALUResult, ReadData2, MemRead, MemWrite, ReadData);
   
endmodule
