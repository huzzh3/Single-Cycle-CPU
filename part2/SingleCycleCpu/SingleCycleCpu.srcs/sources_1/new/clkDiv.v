`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/27 11:33:35
// Design Name: 
// Module Name: clkDiv
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


module clkDiv( //时钟分频
    input clk,
    output reg div_clk = 0
    );
    
    reg [25:0] div_counter = 0;
    always @(posedge clk) begin
        if(div_counter >= 50000) begin //记得改回50000
            div_clk <= ~div_clk;
            div_counter <= 0;
        end
        else div_counter <= div_counter + 1;
    end
endmodule
