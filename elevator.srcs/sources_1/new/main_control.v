`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/16 17:19:59
// Design Name: 
// Module Name: main_control
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


module main_control(
    input clk,
    input clk_100Hz,
    input [1:3] button0,//外 向上按钮
    input [2:4] button1,//外 向下按钮
    input [1:4] floor,//内 目标楼层按钮
    output reg led_up,led_down,led_stay,//三种状态灯
    output reg [3:0] now_floor//当前楼层
    );
    reg [1:0] direction=0;//电梯的方向状态
    parameter stay=2'b00,
               up=2'b01,
               down=2'b10;
    reg [3:0] cstate=0;//电梯的位置状态
    reg [3:0] nstate;
    parameter stop_1=4'b0000,
               stop_2=4'b0001,
               stop_3=4'b0010,
               stop_4=4'b0011,
               up_12=4'b0100,
               up_23=4'b0101,
               up_34=4'b0110,
               down_43=4'b0111,
               down_32=4'b1000,
               down_21=4'b1001;
               
    wire [1:4]request_total;//总的请求
    reg [1:4] in_floor;
    reg [1:3] button_up;
    reg [2:4] button_down;
    assign request_total={in_floor[1]|button_up[1],in_floor[2]|button_up[2]|button_down[2],in_floor[3]|button_up[3]|button_down[3],in_floor[4]|button_down[4]};
    
    reg [19:0] count=0;
    reg [19:0] count1=0;  
    reg [19:0] count2=0;  
    reg [19:0] count3=0;  
    reg [19:0] count4=0;
    reg [19:0] count5=0;
    reg [19:0] count6=0;
    reg [19:0] count7=0;
    reg [19:0] count8=0;
    reg [19:0] count9=0;

    initial begin 
        in_floor<=4'b0000;
        button_up<=3'b000;
        button_down<=3'b000;
    end 
    //消除抖动
    always @(posedge clk) fork
        if(floor[1]) begin
            count<=count+1'b1;
            if(count>=20'hfffff) in_floor[1]<=1;
            end 
        else count<=20'd0;
        if(cstate==stop_1) in_floor[1]<=0;
    join
    
    always @(posedge clk) fork
        if(floor[2]) begin
            count1<=count1+1'b1;
            if(count1>=20'hfffff) in_floor[2]<=1;end
        else count1<=20'd0;
        if(cstate==stop_2) in_floor[2]<=0;
    join
    
    always @(posedge clk) fork
        if(floor[3]) begin
            count2<=count2+1'b1;
            if(count2>=20'hfffff) in_floor[3]<=1;end
        else count2<=20'd0;
        if(cstate==stop_3) in_floor[3]<=0;
    join
    
    always @(posedge clk) fork 
        if(floor[4]) begin
            count3<=count3+1'b1;
            if(count3>=20'hfffff) in_floor[4]<=1;end
        else count3<=20'd0;
        if(cstate==stop_4) in_floor[4]<=0;
     join   
     
     //上下行按钮
     
     always @(posedge clk) begin
         if(button0[1]) begin
            count4<=count4+'b1;
            if(count4>=20'hfffff) button_up[1]<=1;
         end
         if(cstate==stop_1) button_up[1]=0;
     end 
     always @(posedge clk) begin
         if(button0[2]) begin
              count5<=count5+'b1;
              if(count5>=20'hfffff) button_up[2]<=1;
          end
         if(cstate==stop_2&&direction!=down) button_up[2]=0;
     end 
     always @(posedge clk) begin
         if(button0[3]) begin 
            count6<=count6+1'b1;
            if(count6>=20'hfffff) button_up[3]<=1;
         end
         if(cstate==stop_3&&direction!=down) button_up[3]=0;
     end 
     always @(posedge clk) begin
         if(button1[2]) begin 
            count7<=count7+1'b1;
            if(count7>=20'hfffff) button_down[2]<=1;
         end 
         if(cstate==stop_2&&direction!=up) button_down[2]=0;
     end 
     always @(posedge clk) begin
         if(button1[3]) begin 
            count8<=count8+1'b1;
            if(count8>=20'hfffff) button_down[3]<=1;
         end
         if(cstate==stop_3&&direction!=up) button_down[3]=0;
     end 
     always @(posedge clk) begin
         if(button1[4]) begin 
            count9<=count9+1'b1;
            if(count9>=20'hfffff) button_down[4]<=1;
         end 
         if(cstate==stop_4) button_down[4]=0;
     end 
    //3s延时
    reg [9:0] counter=0;
    parameter n=299;
    
    always @(posedge clk)
        cstate<=nstate;
        
    always @(posedge clk)
        case(cstate)
            stop_1:
                case(direction)
                    stay://暂停状态
                        if(request_total[2]||request_total[3]||request_total[4])//2，3，4楼有请求 
                            direction<=up;
                    up: begin nstate<=up_12;end
                    down: direction<=stay;
                endcase
            stop_2:
                case(direction)
                    stay:
                        fork
                        if(request_total[3]||request_total[4])//3，4楼有请求 
                            direction<=up;
                        if(request_total[1])//1楼有请求 
                            direction<=down;
                        join
                    up:
                        begin nstate<=up_23;end
                    down:
                        begin nstate<=down_21;end
                endcase
            stop_3:
                case(direction)
                    stay:
                        fork
                        if(request_total[4])//4楼有请求 
                            direction<=up;
                        if(request_total[1]||request_total[2])//1,2楼有请求 
                            direction<=down;
                        join
                    up:
                        begin nstate<=up_34;end
                    down:
                        begin nstate<=down_32;end
                endcase 
            stop_4:
                case(direction)
                    stay://暂停状态
                        if(request_total[2]||request_total[3]||request_total[1])//1,2，3楼有请求 
                            direction<=down;
                    up: direction<=stay;
                    down: begin nstate<=down_43;end
                endcase 
            up_12:
                if(clk_100Hz) begin
                    counter<=counter+1;
                    if(counter==n) begin
                        if(button_up[3]==0&&in_floor[3]==0&&in_floor[4]==0)//只接受向上的请求和内部的请求
                            direction<=stay;
                        nstate<=stop_2;
                        counter<=0;
                    end
                end
                
            up_23:
                if(clk_100Hz) begin
                    counter<=counter+1;
                    if(counter==n) begin
                        if(in_floor[4]==0)//
                            direction<=stay;
                        nstate<=stop_3;
                        counter<=0;
                    end 
                end 
            up_34:
                if(clk_100Hz) begin 
                    counter<=counter+1;
                    if(counter==n) begin
                        nstate<=stop_4;
                        direction<=stay;
                        counter<=0;
                    end
                end
            down_43:
                if(clk_100Hz) begin
                    counter<=counter+1;
                    if(counter==n) begin
                        if(button_down[2]==0&&in_floor[1]==0&&in_floor[2]==0)
                            direction<=stay;
                        nstate<=stop_3;
                        counter<=0;
                    end
                end
            down_32:
                if(clk_100Hz) begin
                    counter<=counter+1;
                    if(counter==n) begin
                        if(in_floor[1]==0)
                            direction<=stay;
                        nstate<=stop_2;
                        counter<=0;
                    end
                end 
            down_21:
                if(clk_100Hz) begin
                    counter<=counter+1;
                    if(counter==n) begin
                        nstate<=stop_1;
                        direction<=stay;
                        counter<=0;
                    end 
                end
        endcase 
        //当前楼层的状态变化
        always @(posedge clk) begin
            case(cstate)
                stop_1: now_floor<=1;
                stop_2: now_floor<=2;
                stop_3: now_floor<=3;
                stop_4: now_floor<=4;
                default: now_floor<=now_floor;
            endcase
        end
        //运行状态的LED灯输出
        always @(posedge clk) begin 
            case(direction)
                stay:begin led_stay=1;led_up=0;led_down=0;end
                up:begin led_stay=0;led_up=1;led_down=0;end
                down:begin led_stay=0;led_up=0;led_down=1;end
            endcase
        end    
endmodule 
