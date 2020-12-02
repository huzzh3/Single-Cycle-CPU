`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/27 11:27:43
// Design Name: 
// Module Name: smgMux
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


module smgMux( //���������ÿ��ֻ����ʾһ�����֣�����Ҫ����һ��ģ�飬ÿ��ѡ��һ����������ʾ
    input [1:0] choice, //ѡ���ź�
    input [3:0] hex0, //����ĵ�һ��ʮ��������
    input [3:0] hex1, //����ĵڶ���ʮ��������
    input [3:0] hex2, //����ĵ�����ʮ��������
    input [3:0] hex3, //����ĵ��ĸ�ʮ��������
    output reg [3:0] outputHex //ѡ��ó���ʮ��������
    );
    always@(*) begin
        case(choice)
            0: outputHex = hex0;
            1: outputHex = hex1;
            2: outputHex = hex2;
            3: outputHex = hex3;
        endcase
    end
endmodule
