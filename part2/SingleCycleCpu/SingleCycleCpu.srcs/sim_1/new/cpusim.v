`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/26 23:39:56
// Design Name: 
// Module Name: cpusim
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


module cpusim();
    reg clk;
    wire [15:0] q;
    wire [31:0] data0;
    wire [31:0] data1;
    wire [31:0] data2;
    wire [31:0] data3;
    wire [31:0] data4;
    wire [31:0] data5;
    wire [31:0] data6;
    wire [31:0] data7;
    
    CPUTOP uut(clk, q, data0, data1, data2, data3, data4, data5, data6, data7);
    
    initial begin 
        clk = 0;
    end
    always #5 clk = ~clk;
endmodule
