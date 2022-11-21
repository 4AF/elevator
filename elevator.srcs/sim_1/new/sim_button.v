`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/15 02:03:58
// Design Name: 
// Module Name: sim_button
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


module sim_button();
    reg button1=0;
    wire button2;
    
    always #10 button1=~button1;
    button u(.button1(button1),.button2(button2));
endmodule
