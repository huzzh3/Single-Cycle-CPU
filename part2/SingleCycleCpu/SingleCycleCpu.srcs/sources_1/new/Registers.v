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
    input clk, //注意writeRegister是通过时钟信号来触发写信号的，故你需要输入时钟信号来完成writeRegister
    input regWrite, //寄存器写信号
    input [4:0] ReadRegister1,
    input [4:0] ReadRegister2,
    input [4:0] WriteRegister,
    input [31:0] WriteData,
    output [31:0] ReadData1,
    output [31:0] ReadData2
    );
    reg [31:0] registerFile [1:31]; //定义$1~$31的寄存器，$0是$zero，故保留它的位置，防止被修改，每个寄存器都是32位，故为[31:0]
    integer i;
    initial begin
        for (i = 1; i <= 31; i = i + 1) registerFile[i] = 0;//初始化寄存器堆
        
        registerFile[5] = 32'h00000008;     //初始化$a1位为8，也就是要排序的数组长度为8
    end
    assign ReadData1 = (ReadRegister1 == 4'b0000) ? 0 : registerFile[ReadRegister1];  //加上ReadRegister1 == 4'b0000这句话就是为了给$0寄存器定义的
    assign ReadData2 = (ReadRegister2 == 4'b0000) ? 0 : registerFile[ReadRegister2];
    always @(posedge clk) begin
        if (regWrite == 1 && WriteRegister != 4'b0000)  //如果寄存器给了写信号并且写入的不是$0寄存器($0是0不能被修改)，则需要写入寄存器
            registerFile[WriteRegister] <= WriteData;
    end
endmodule

