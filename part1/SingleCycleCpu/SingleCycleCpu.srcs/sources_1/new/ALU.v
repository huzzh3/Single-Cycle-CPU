`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 23:38:55
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [3:0] ALUControlSingal,//ALU控制信号
    input [31:0] inputData1, //输入的一号数据，记得是32位
    input [31:0] inputData2, //输入的二号数据
    output zero, //用于判断ALU的结果是不是0，主要用在beq指令中
    output reg [31:0] result
    );
    initial result = 0;
    assign zero = (result == 0) ? 1 : 0; //如果结果为0，那么zero就为1，表明结果为0
    always @(*) begin
        case(ALUControlSingal)
            4'b0000: result <= inputData1 & inputData2; //0000表示且运算
            4'b0001: result <= inputData1 | inputData2; //0001表示或运算
            4'b0010: result <= inputData1 + inputData2; //0010表示加法
            4'b0110: result <= inputData1 - inputData2; //0110表示减法
            4'b0111: begin                             //0111表示slt
                if (inputData1 < inputData2)
                    result <= 1;
                else
                    result <= 0;
            end
            4'b1100: result <= inputData1 ^ inputData2; //1100表示异或
        endcase
    end
endmodule
