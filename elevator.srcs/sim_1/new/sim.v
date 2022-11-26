`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/15 11:44:49
// Design Name: 
// Module Name: sim
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


module sim(

    );
    reg clk;
    wire clk_100Hz;
    
    initial begin 
        clk=1;end
    always #5 clk=~clk;
    clk_100Hz u(.clk(clk),.clk_100Hz(clk_100Hz));
endmodule
