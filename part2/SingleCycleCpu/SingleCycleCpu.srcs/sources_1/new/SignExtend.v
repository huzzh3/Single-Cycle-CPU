`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 23:36:22
// Design Name: 
// Module Name: SignExtend
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


module SignExtend(
    input [15:0] instruction,
    output [31:0] outputData
    );
    assign outputData = instruction[15:15] ? {16'hffff, instruction} : {16'h0000, instruction}; //根据符号位进行相应的符号拓展
endmodule
