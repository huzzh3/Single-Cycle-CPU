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
   wire [31:0] ReadData;//Data memory 读出的数据
   wire [31:0] currentPCAdd4 = currentPC + 4;
   wire [31:0] nextPC;
   wire [31:0] ALUResult;
   
   
   assign nextPC = (Jump) ? {currentPCAdd4[31:28], Instruction[25:0], 2'b00} : //这部分用来实现Jump和beq的跳转
                   (Branch && zero) ? currentPCAdd4+(extendedData<<2) : 
                   (Instruction[5:0] == 6'b001000 && Instruction[31:26] == 6'b000000 ? ALUResult : currentPCAdd4);
    //这里进行了修改，加入了jr语句，如果是jr语句的话，那么直接用ALUResult的结果作为下一个PC，跳转就好了
   
   assign WriteRegister = RegDst ? Instruction[15:11] : 
                         (Jump == 0 ? Instruction[20:16] : 
                         (RegWrite == 1 ? 5'b11111 : 0)); 
   //这里进行了修改，如果RegDst==0的时候还要判断有没有跳转信号，如果没有的话说明不是jal和j语句，有的话就说明是jal或j语句，之后在判断有没有写寄存器信号，有的话说明是jal语句，没有的话说明是j语句
   assign ALUInputData2 = ALUSrc ? extendedData : ReadData2; //Mux(2)
   assign WriteData = MemtoReg ? ReadData : 
                      (Jump == 0 ? ALUResult : 
                      (RegWrite == 1 ? currentPCAdd4 : 0));
   //同样，这里进行了修改，如果是jal语句的话，则写入的数据是currentPC+4
   
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
