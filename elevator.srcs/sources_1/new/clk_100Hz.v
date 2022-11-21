`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/11 17:50:09
// Design Name: 
// Module Name: pulse_3sec
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


module clk_100Hz(
    input clk,
    output reg clk_100Hz
    );
    //此模块生成一个100Hz的脉冲
    //clk:EGO1的时钟信号，100MHz
    //clk_100Hz:分频产生的100Hz的脉冲信号
    reg [30:0] counter=0;//用于时间计数   
    always @(posedge clk)//计数
         if(counter==1000000-1)
             counter<=0;
         else 
            counter<=counter+1;
    //1秒
    always @(posedge clk)//计数，若m=1000000-1,则归零
        if(counter==1000000-1)
            clk_100Hz<=1;
        else clk_100Hz<=0;
    

            
endmodule
