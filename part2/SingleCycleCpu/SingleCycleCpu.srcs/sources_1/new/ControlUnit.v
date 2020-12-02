`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 23:38:01
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
    input [5:0] opcode, //6位opcode
    output reg RegDst, //告诉Mux(1)选rd
    output reg Jump, //跳转指令
    output reg Branch, //分支指令
    output reg MemRead, //读内存指令
    output reg MemtoReg, //写入寄存器指令，用于lw
    output reg [2:0] ALUOp, //用于ALUControl
    output reg MemWrite, //写内存指令，用于Data memory
    output reg ALUSrc, //告诉Mux(2)选ReadData2还是符号拓展之后的数
    output reg RegWrite //寄存器写信号
    );
    //这里涉及的opcode一共有001000(addi),100011(lw),000000(R格式)，000100(beq),000010(j),101011(sw),故暂时只实现这些功能，后面如果有需要会再添加
    initial begin
        RegDst = 0;
        ALUSrc = 0;
        MemtoReg = 0;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        ALUOp = 3'b000;
        Jump = 0;
    end
    always@(opcode) begin
    //opcode改变了就进入always
        case(opcode)
            6'b000000: begin //R格式指令
                RegDst = 1;//这时候由于是R格式，就有rd寄存器，故Mux(1)需要选择rd寄存器
                ALUSrc = 0; //告诉Mux(2)为0，即选择ReadData2
                MemtoReg = 0;//R格式的指令中没有需要从内存写入寄存器的指令
                RegWrite = 1;//R格式指令需要写入rd
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 3'b010; //用于告诉ALU Control
                Jump = 0;
            end
            6'b000010: begin //J格式指令
                RegDst = 0;
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 3'b000; //J格式指令用不到ALUOp，随便设置即可
                Jump = 1;
            end
            6'b000100: begin //beq指令
                RegDst = 0;
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 1;
                ALUOp = 3'b001;//beq指令要进行减法
                Jump = 0;
            end
            6'b001000: begin//addi指令
                RegDst = 0;
                ALUSrc = 1; //这时候Mux(2)要选择符号拓展的数了
                MemtoReg = 0;
                RegWrite = 1; //需要写入寄存器
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 3'b000;//addi指令进行加法
                Jump = 0;
            end
            6'b100011: begin //lw指令
                RegDst = 0;
                ALUSrc = 1; //这时候Mux(2)要选择符号拓展的数了
                MemtoReg = 1;//需要从存储器中提取数据写入寄存器
                RegWrite = 1; //需要写入寄存器
                MemRead = 1;//需要读取内存中的数据了
                MemWrite = 0;
                Branch = 0;
                ALUOp = 3'b000;//lw指令进行加法
                Jump = 0;
            end
            6'b101011: begin //sw指令
                RegDst = 0;
                ALUSrc = 1; //这时候Mux(2)要选择符号拓展的数了
                MemtoReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 1;//需要写入内存
                Branch = 0;
                ALUOp = 3'b000;//sw指令进行加法
                Jump = 0;
            end
            6'b001010: begin //slti指令
                RegDst = 0;
                ALUSrc = 1; //要选择符号拓展的数
                MemtoReg = 0;
                RegWrite = 1; //需要写入寄存器
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 3'b100; //告诉ALU小于设置
                Jump = 0;
            end
            6'b000101: begin //bne指令
                RegDst = 0;
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 1;
                ALUOp = 3'b110; //告诉ALU是减法，但是zero设置要改
                Jump = 0;
            end
            6'b000011: begin //jal
                RegDst = 0;
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 1; //要把PC+4写入$ra
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 3'b000; // 用不到ALUOp，随便设计
                Jump = 1;
            end
        endcase
    end
endmodule
