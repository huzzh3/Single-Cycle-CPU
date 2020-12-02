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
    input clk,//������Ұ���ʱ��
    input basys3Clk, //ϵͳ�Դ�ʱ��
    output [3:0] enable, //���ߵ�·���ĸ�LED��
    output [7:0] segmentCode //��Ӧ���߶������
    );
    wire [15:0] q;
    wire next_signal;//������������ֶ��ź�
    
    Button_Debounce uButton_Debounce(basys3Clk, clk, next_signal);
    CPUTOP uCPUTOP(next_signal, q);
    smg usmg(basys3Clk, q[15:12], q[11:8], q[7:4], q[3:0], enable, segmentCode);
endmodule
