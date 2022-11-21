`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/15 10:36:14
// Design Name: 
// Module Name: shumaguan
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/27 22:30:42
// Design Name: 
// Module Name: shumaguan
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


module shumaguan(
		 input [3:0] data,
		 output reg [6:0] a_to_g,
		 output an
    );
    //��ģ����������ܵ���ʾ�����������BCD����ʾ����
    //data:�����BCD�룬Ҫ��ʾ������
    //a_to_g:�����źţ�����������ܣ��������Ч���߶������
    //an:ʹ���ź�
    always @* begin 
        case(data)
            0:a_to_g=7'b1111110;
            1:a_to_g=7'b0110000;
            2:a_to_g=7'b1101101;
            3:a_to_g=7'b1111001;
            4:a_to_g=7'b0110011;
            5:a_to_g=7'b1011011;
            6:a_to_g=7'b1011111;
            7:a_to_g=7'b1110000;
            8:a_to_g=7'b1111111;
            9:a_to_g=7'b1111011;
            default:a_to_g=7'b1111110;
        endcase
    end
    assign an=1;
endmodule

