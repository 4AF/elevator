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
    reg clk,rst;
    wire clk_3s;
    
    initial begin 
        clk=1;rst=1;
        #1 rst=0;end
    always #5 clk=~clk;
    pulse_3sec u(.clk(clk),.rst(rst),.clk_3s(clk_3s));
endmodule
