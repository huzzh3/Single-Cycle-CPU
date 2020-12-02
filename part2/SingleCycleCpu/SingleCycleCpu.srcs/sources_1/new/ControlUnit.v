`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 23:38:01
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
    input [5:0] opcode, //6λopcode
    output reg RegDst, //����Mux(1)ѡrd
    output reg Jump, //��תָ��
    output reg Branch, //��ָ֧��
    output reg MemRead, //���ڴ�ָ��
    output reg MemtoReg, //д��Ĵ���ָ�����lw
    output reg [2:0] ALUOp, //����ALUControl
    output reg MemWrite, //д�ڴ�ָ�����Data memory
    output reg ALUSrc, //����Mux(2)ѡReadData2���Ƿ�����չ֮�����
    output reg RegWrite //�Ĵ���д�ź�
    );
    //�����漰��opcodeһ����001000(addi),100011(lw),000000(R��ʽ)��000100(beq),000010(j),101011(sw),����ʱֻʵ����Щ���ܣ������������Ҫ�������
    initial begin
        RegDst = 0;
        ALUSrc = 0;
        MemtoReg = 0;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        ALUOp = 3'b000;
        Jump = 0;
    end
    always@(opcode) begin
    //opcode�ı��˾ͽ���always
        case(opcode)
            6'b000000: begin //R��ʽָ��
                RegDst = 1;//��ʱ��������R��ʽ������rd�Ĵ�������Mux(1)��Ҫѡ��rd�Ĵ���
                ALUSrc = 0; //����Mux(2)Ϊ0����ѡ��ReadData2
                MemtoReg = 0;//R��ʽ��ָ����û����Ҫ���ڴ�д��Ĵ�����ָ��
                RegWrite = 1;//R��ʽָ����Ҫд��rd
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 3'b010; //���ڸ���ALU Control
                Jump = 0;
            end
            6'b000010: begin //J��ʽָ��
                RegDst = 0;
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 3'b000; //J��ʽָ���ò���ALUOp��������ü���
                Jump = 1;
            end
            6'b000100: begin //beqָ��
                RegDst = 0;
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 1;
                ALUOp = 3'b001;//beqָ��Ҫ���м���
                Jump = 0;
            end
            6'b001000: begin//addiָ��
                RegDst = 0;
                ALUSrc = 1; //��ʱ��Mux(2)Ҫѡ�������չ������
                MemtoReg = 0;
                RegWrite = 1; //��Ҫд��Ĵ���
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 3'b000;//addiָ����мӷ�
                Jump = 0;
            end
            6'b100011: begin //lwָ��
                RegDst = 0;
                ALUSrc = 1; //��ʱ��Mux(2)Ҫѡ�������չ������
                MemtoReg = 1;//��Ҫ�Ӵ洢������ȡ����д��Ĵ���
                RegWrite = 1; //��Ҫд��Ĵ���
                MemRead = 1;//��Ҫ��ȡ�ڴ��е�������
                MemWrite = 0;
                Branch = 0;
                ALUOp = 3'b000;//lwָ����мӷ�
                Jump = 0;
            end
            6'b101011: begin //swָ��
                RegDst = 0;
                ALUSrc = 1; //��ʱ��Mux(2)Ҫѡ�������չ������
                MemtoReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 1;//��Ҫд���ڴ�
                Branch = 0;
                ALUOp = 3'b000;//swָ����мӷ�
                Jump = 0;
            end
            6'b001010: begin //sltiָ��
                RegDst = 0;
                ALUSrc = 1; //Ҫѡ�������չ����
                MemtoReg = 0;
                RegWrite = 1; //��Ҫд��Ĵ���
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 3'b100; //����ALUС������
                Jump = 0;
            end
            6'b000101: begin //bneָ��
                RegDst = 0;
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 1;
                ALUOp = 3'b110; //����ALU�Ǽ���������zero����Ҫ��
                Jump = 0;
            end
            6'b000011: begin //jal
                RegDst = 0;
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 1; //Ҫ��PC+4д��$ra
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 3'b000; // �ò���ALUOp��������
                Jump = 1;
            end
        endcase
    end
endmodule
