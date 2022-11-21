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
    //��ģ������һ��100Hz������
    //clk:EGO1��ʱ���źţ�100MHz
    //clk_100Hz:��Ƶ������100Hz�������ź�
    reg [30:0] counter=0;//����ʱ�����   
    always @(posedge clk)//����
         if(counter==1000000-1)
             counter<=0;
         else 
            counter<=counter+1;
    //1��
    always @(posedge clk)//��������m=1000000-1,�����
        if(counter==1000000-1)
            clk_100Hz<=1;
        else clk_100Hz<=0;
    

            
endmodule
