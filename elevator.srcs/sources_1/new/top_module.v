`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/15 22:01:59
// Design Name: 
// Module Name: top_module
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


module top_module(
    input clk,
    input [1:3] button_up,
    input [2:4] button_down,
    input [1:4] floor,
    output led_up,led_down,led_stay,
    output [6:0] a_to_g,
    output an
    );
    wire clk_100Hz;
    clk_100Hz u1(.clk(clk),.clk_100Hz(clk_100Hz));
    wire [3:0] now_floor;
    main_control u2(.clk(clk),.clk_100Hz(clk_100Hz),.button0(button_up),.button1(button_down),.floor(floor),.led_up(led_up),.led_down(led_down),
            .led_stay(led_stay),.now_floor(now_floor));
    shumaguan u3(.data(now_floor),.a_to_g(a_to_g),.an(an));
endmodule
