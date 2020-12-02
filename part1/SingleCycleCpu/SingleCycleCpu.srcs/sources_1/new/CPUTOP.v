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
   wire RegDst; //告诉Mux(1)选rd
   wire Jump; //跳转指令
   wire Branch; //分支指令
   wire MemRead; //读内存指令
   wire MemtoReg; //写入寄存器指令，用于lw
   wire [2:0] ALUOp; //用于ALUControl
   wire MemWrite; //写内存指令，用于Data memory
   wire ALUSrc; //告诉Mux(2)选ReadData2还是符号拓展之后的数
   wire RegWrite; //寄存器写信号
   wire [31:0] WriteData; //要被写入的数据
   wire [4:0] WriteRegister; //要写入的寄存器
   wire [31:0] ReadData1; //读出的第一数据
   wire [31:0] ReadData2; //读出的第二数据
   wire [31:0] extendedData; //符号拓展之后的数
   wire [31:0] ALUInputData2; //ALU的第二输出数
   wire [3:0] ALUControlSingal; //ALU控制信号
   wire zero;
   wire [31:0] ALUResult;
   wire [31:0] ReadData;//Data memory 读出的数据
   wire [31:0] nextPC;
   wire [31:0] currentPCAdd4 = currentPC + 4;
   
   assign nextPC = (Jump) ? {currentPCAdd4[31:28], Instruction[25:0], 2'b00} : //这部分用来实现Jump和beq的跳转
                   (Branch && zero) ? currentPCAdd4+(extendedData<<2) : currentPCAdd4;
   
   assign WriteRegister = RegDst ? Instruction[15:11] : Instruction[20:16]; //Mux(1)的功能，很容易使用条件语句实现，为了方便，就不要多写一个模块了
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
