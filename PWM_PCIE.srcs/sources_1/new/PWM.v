`timescale 1ns / 1ps


module PWM(
    input wire clk,
    input wire rst, //KEY2
    input wire key, //KEY1
    output reg PWM_ON_led, //When the PWM signal is on, this led is on as well.  LED1
    output reg PWM_DUTYCYCLE_HANDLER_led // This led is on if dutycycle need to be increased.  LED2
);
    parameter PWM_TIMER_MAX = 499999; //10ms
    parameter PWM_OFFSET = 5000; //increase or decrease dutycycle by this offset
    parameter TIMER_2s = 199; //2s
    
                /*ON_period*/
    reg [18:0] ON_period = 'd5000; //initializing dutycycle
    reg PWM_DUTYCYCLE_HANDLER = 'd1; // 1: increase dutycycle
    reg [18:0] timer = 'd0;
    
    always@ (posedge clk or negedge rst) begin
        if(timer == PWM_TIMER_MAX) begin
            if(PWM_DUTYCYCLE_HANDLER) begin
                ON_period <= ON_period + PWM_OFFSET;
            end
            else begin
                ON_period <= ON_period - PWM_OFFSET;
            end
        end
        else if(!rst) begin 
           ON_period <= 'd5000; 
        end
        else begin
           ON_period <= ON_period;
        end
    end
    
                /*TIMER*/
    always@ (posedge clk or negedge rst) begin
        if(rst == 'd0 || (timer == PWM_TIMER_MAX)) begin
            timer <= 'd0;
        end
        else begin
            timer <= timer + 'd1;
        end
    end
  
              /*PWM_ON_led*/
    always@ (timer) begin
        if(timer > ON_period) begin
            PWM_ON_led = 1'b0;
        end
        else begin
            PWM_ON_led = 1'b1;
        end
    end
    
    /*using key to determined PWM_DUTYCYCLE_HANDLER*/
    always@ (posedge clk) begin
        if(!key) begin
            PWM_DUTYCYCLE_HANDLER <= !PWM_DUTYCYCLE_HANDLER;
        end
        else begin
            PWM_DUTYCYCLE_HANDLER <= PWM_DUTYCYCLE_HANDLER;
        end        
    end
    
             /*PWM_DUTYCYCLE_HANDLER_led*/
    always@ (PWM_DUTYCYCLE_HANDLER) begin
        if(PWM_DUTYCYCLE_HANDLER) begin
            PWM_DUTYCYCLE_HANDLER_led <= 'd1;
        end
        else begin
            PWM_DUTYCYCLE_HANDLER_led <= 'd0;
        end
    end
    
endmodule
