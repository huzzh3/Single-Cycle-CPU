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
    wire [31:0] data0;
    wire [31:0] data1;
    wire [31:0] data2;
    wire [31:0] data3;
    wire [31:0] data4;
    wire [31:0] data5;
    wire [31:0] data6;
    wire [31:0] data7;
    wire [31:0] selectData;
    
    CPUTOP uCPUTOP(basys3Clk, q, data0, data1, data2, data3, data4, data5, data6, data7);
    dataSelect udataSelect(clk, data0, data1, data2, data3, data4, data5, data6, data7, selectData);
    smg usmg(basys3Clk, selectData[15:12], selectData[11:8], selectData[7:4], selectData[3:0], enable, segmentCode);
endmodule
