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
    input [4:0] shamt,
    input [3:0] ALUControlSingal,//ALU�����ź�
    input [31:0] inputData1, //�����һ�����ݣ��ǵ���32λ
    input [31:0] inputData2, //����Ķ�������
    output zero, //�����ж�ALU�Ľ���ǲ���0����Ҫ����beqָ����
    output reg [31:0] result
    );
    initial result = 0;
    assign zero = (ALUControlSingal !=  4'b0011) ? ((result == 0) ? 1 : 0) : ((result == 0) ? 0 : 1); //�������0011���źţ�Ҳ���ǲ���bne���źţ���ô�����ж�zero�ͺ��ˣ������0011���źţ�����Ҫ���жϽ���޸�
    always @(*) begin
        case(ALUControlSingal)
            4'b0000: result <= inputData1 & inputData2; //0000��ʾ������
            4'b0001: result <= inputData1 | inputData2; //0001��ʾ������
            4'b0010: result <= inputData1 + inputData2; //0010��ʾ�ӷ�
            4'b0110: result <= inputData1 - inputData2; //0110��ʾ����
            4'b0111: begin                             //0111��ʾslt
                if (inputData1 < inputData2 || inputData1 == 32'hffffffff)
                    result <= 1;
                else
                    result <= 0;
            end
            4'b1100: result <= inputData1 ^ inputData2; //1100��ʾ���
            4'b0011: result <= inputData1 - inputData2; //0011��ʾ����������Ҫ��zero
            4'b1000: result <= inputData2 << shamt;
        endcase
    end
endmodule
