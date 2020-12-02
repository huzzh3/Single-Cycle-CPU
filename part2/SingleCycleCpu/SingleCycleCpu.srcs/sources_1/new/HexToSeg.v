`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/27 11:16:59
// Design Name: 
// Module Name: HexToSeg
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


module HexToSeg( //将十六进制数转换为七段码，供数码管使用
    input [3:0] hexNumber,
    output reg [7:0] segmentCode
    );
    
    always @(hexNumber) begin //每次输入的十六进制数发生变化，则进入always语句
        case(hexNumber)
            4'h0: segmentCode = 8'b11000000;
            4'h1: segmentCode = 8'b11111001;
            4'h2: segmentCode = 8'b10100100;
            4'h3: segmentCode = 8'b10110000;
            4'h4: segmentCode = 8'b10011001;
            4'h5: segmentCode = 8'b10010010;
            4'h6: segmentCode = 8'b10000010;
            4'h7: segmentCode = 8'b11011000;
            4'h8: segmentCode = 8'b10000000;
            4'h9: segmentCode = 8'b10010000;
            4'hA: segmentCode = 8'b10001000;
            4'hB: segmentCode = 8'b10000011;
            4'hC: segmentCode = 8'b11000110;
            4'hD: segmentCode = 8'b10100001;
            4'hE: segmentCode = 8'b10000110;
            4'hF: segmentCode = 8'b10001110;
            default: segmentCode = 8'b00000000;
        endcase
    end
endmodule
