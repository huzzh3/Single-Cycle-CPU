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
    
    CPUTOP uut(clk, q);
    
    initial begin 
        clk = 0;
    end
    always #5 clk = ~clk;
endmodule
