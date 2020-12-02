`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/27 11:36:10
// Design Name: 
// Module Name: counter4
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


module counter4( //计数器，配合smgMux使用来选择显示的数字
    input clk,
    output reg [1:0] count = 0
    );
    always @(posedge clk) begin
        if(count == 2'b11) count <= 0;
        else count <= count + 1;
    end
endmodule
