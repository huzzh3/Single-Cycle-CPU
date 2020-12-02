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
    input clk,//注意这里的写信号同样是需要时钟来触发的，故需要时钟信号
    input [31:0] Address, //32位的数据地址
    input [31:0] WriteData, //要写入的数据
    input MemRead, //读信号
    input MemWrite, //写信号
    output [31:0] ReadData //读出的数据
    );
    reg [7:0] memoryRAM [0:47]; //类似于InstructionMemory中的定义一样，这里也是一个字，即8位为一个存储单元，一共有48个存储单元(如果不够把数字改大点就好了)
    integer i;
    initial begin//存入预存数据
        for(i = 0; i <= 47; i = i + 1) memoryRAM[i] = 0; //初始化，非常重要，防止出错
        
        memoryRAM[4] = 8'h00;
        memoryRAM[5] = 8'h00;
        memoryRAM[6] = 8'h00;
        memoryRAM[7] = 8'h06;
        memoryRAM[8] = 8'h00;
        memoryRAM[9] = 8'h00;
        memoryRAM[10] = 8'h00;
        memoryRAM[11] = 8'h09;
    end
    assign ReadData[31:24] = (MemRead == 1) ? memoryRAM[Address+0] : 8'bz; //如果没有写信号，那么就把这32位全部定义为z，即不确定电平
    assign ReadData[23:16] = (MemRead == 1) ? memoryRAM[Address+1] : 8'bz;
    assign ReadData[15:8]  = (MemRead == 1) ? memoryRAM[Address+2] : 8'bz;
    assign ReadData[7:0]   = (MemRead == 1) ? memoryRAM[Address+3] : 8'bz;
    
    always @(posedge clk) begin
        //在时钟上升沿写入
        if (MemWrite == 1) begin
            memoryRAM[Address+0] <= WriteData[31:24];
            memoryRAM[Address+1] <= WriteData[23:16];
            memoryRAM[Address+2] <= WriteData[15:8];
            memoryRAM[Address+3] <= WriteData[7:0];
        end
    end 
endmodule

