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


module smgMux( //由于数码管每次只能显示一个数字，故需要这样一个模块，每次选择一个数字来显示
    input [1:0] choice, //选择信号
    input [3:0] hex0, //输入的第一个十六进制数
    input [3:0] hex1, //输入的第二个十六进制数
    input [3:0] hex2, //输入的第三个十六进制数
    input [3:0] hex3, //输入的第四个十六进制数
    output reg [3:0] outputHex //选择得出的十六进制数
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
