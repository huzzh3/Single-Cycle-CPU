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
    output [31:0] ReadData, //读出的数据
    
    output [31:0] data0, //存放排序数组的第零号数据，作为接口，便于后面的写板
    output [31:0] data1,
    output [31:0] data2,
    output [31:0] data3,
    output [31:0] data4,
    output [31:0] data5,
    output [31:0] data6,
    output [31:0] data7
    );
    reg [7:0] memoryRAM [0:47]; //类似于InstructionMemory中的定义一样，这里也是一个字，即8位为一个存储单元，一共有48个存储单元(如果不够把数字改大点就好了)
    integer i;
    initial begin//存入预存数据
        for(i = 0; i <= 47; i = i + 1) memoryRAM[i] = 0; //初始化，非常重要，防止出错
        
        memoryRAM[0] = 8'h00; //存入5
        memoryRAM[1] = 8'h00;
        memoryRAM[2] = 8'h00;
        memoryRAM[3] = 8'h05;
        
        memoryRAM[4] = 8'h00; //存入20
        memoryRAM[5] = 8'h00;
        memoryRAM[6] = 8'h00;
        memoryRAM[7] = 8'h20;
        
        memoryRAM[8] = 8'h00; //存入15
        memoryRAM[9] = 8'h00;
        memoryRAM[10] = 8'h00;
        memoryRAM[11] = 8'h15;
        
        memoryRAM[12] = 8'h00; //存入12
        memoryRAM[13] = 8'h00;
        memoryRAM[14] = 8'h00;
        memoryRAM[15] = 8'h12;
        
        memoryRAM[16] = 8'h00;//存入36
        memoryRAM[17] = 8'h00;
        memoryRAM[18] = 8'h00;
        memoryRAM[19] = 8'h36;
        
        memoryRAM[20] = 8'h00;//存入45
        memoryRAM[21] = 8'h00;
        memoryRAM[22] = 8'h00;
        memoryRAM[23] = 8'h45;
        
        memoryRAM[24] = 8'h00;//存入47
        memoryRAM[25] = 8'h00;
        memoryRAM[26] = 8'h00;
        memoryRAM[27] = 8'h47;
        
        memoryRAM[28] = 8'h00;//存入18
        memoryRAM[29] = 8'h00;
        memoryRAM[30] = 8'h00;
        memoryRAM[31] = 8'h18;
        
    end
    assign ReadData[31:24] = (MemRead == 1) ? memoryRAM[Address+0] : 8'bz; //如果没有写信号，那么就把这32位全部定义为z，即不确定电平
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
        //在时钟上升沿写入
        if (MemWrite == 1) begin
            memoryRAM[Address+0] <= WriteData[31:24];
            memoryRAM[Address+1] <= WriteData[23:16];
            memoryRAM[Address+2] <= WriteData[15:8];
            memoryRAM[Address+3] <= WriteData[7:0];
        end
    end 
endmodule

