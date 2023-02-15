`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/24 16:33:32
// Design Name: 
// Module Name: tb_PWM
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

module tb_PWM();
    
    reg clk;
    reg rst;
    reg key;
    wire PWM_ON_led; //When the PWM signal is on, this led is on as well. 
    wire PWM_DUTYCYCLE_HANDLER_led; // This led is on if dutycycle need to be increased. 
    
    parameter PWM_TIMER_MAX = 499999; //10ms
    parameter PWM_OFFSET = 5000; //increase or decrease dutycycle by this offset
    parameter TIMER_2s = 199; //2s
    
    PWM #(.PWM_TIMER_MAX(PWM_TIMER_MAX), .PWM_OFFSET(PWM_OFFSET), .TIMER_2s(TIMER_2s)) PWM_instance(.clk(clk), .rst(rst), .key(key), .PWM_ON_led(PWM_ON_led), .PWM_DUTYCYCLE_HANDLER_led(PWM_DUTYCYCLE_HANDLER_led));
    
    initial begin
        clk = 1'b0;
        rst = 1'b1;
        forever #10 clk=~clk;
    end
    
    initial begin
        key = 1'b1;
     //   #500 key =~key;
       // #20 key=~key;
    end
    
    
endmodule
