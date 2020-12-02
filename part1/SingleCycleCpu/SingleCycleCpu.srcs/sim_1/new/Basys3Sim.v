`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/27 12:55:14
// Design Name: 
// Module Name: Basys3Sim
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


module Basys3Sim();
    reg clk;
    reg basys3Clk;
    wire [3:0] enable;
    wire [7:0] segmentCode;
    
    Basys3CPU uBasys3CPU(clk, basys3Clk, enable, segmentCode);
    
    initial begin
        clk = 0;
        basys3Clk = 0;
    end
    always #50 clk = ~clk;
    always #5 basys3Clk = ~basys3Clk;
endmodule
