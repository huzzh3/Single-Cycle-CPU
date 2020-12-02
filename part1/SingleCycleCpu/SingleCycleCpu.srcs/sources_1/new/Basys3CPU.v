`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/27 12:50:10
// Design Name: 
// Module Name: Basys3CPU
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


module Basys3CPU(
    input clk,//这个是我按的时钟
    input basys3Clk, //系统自带时钟
    output [3:0] enable, //告诉电路板哪个LED亮
    output [7:0] segmentCode //对应的七段数码管
    );
    wire [15:0] q;
    wire next_signal;//消除抖动后的手动信号
    
    Button_Debounce uButton_Debounce(basys3Clk, clk, next_signal);
    CPUTOP uCPUTOP(next_signal, q);
    smg usmg(basys3Clk, q[15:12], q[11:8], q[7:4], q[3:0], enable, segmentCode);
endmodule
