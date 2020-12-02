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
    reg [7:0] memoryROM [0:163]; //说明一下，这里一个存储单元是8位，一条指令32位，故需要四个存储单元，之后一共有41条指令，故需要164个存储单元
    initial begin //写入翻译好的机器码
        $readmemb("D:/vivadoProject/SingleCycleCpu/SingleCycleCpu.srcs/sources_1/new/sortInstruction.txt", memoryROM);//代码复现的话，需要修改这里的绝对地址
    end
    //通过currentPC降四个内存空间的内容合并成一条指令
    assign instruction[31:24] = memoryROM[currentPC+0];
    assign instruction[23:16] = memoryROM[currentPC+1];
    assign instruction[15:8]  = memoryROM[currentPC+2];
    assign instruction[7:0]   = memoryROM[currentPC+3];
endmodule

