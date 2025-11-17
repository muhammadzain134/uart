`timescale 1ns / 1ps

module Receiver (
    input  logic clk_100MHz,   // 100 MHz system clock
    input  logic rst,          // Asynchronous reset
    input  logic Rx,           // Serial data input line
    output logic Rx_done,      // High when a full byte is received
    output logic [7:0] Dout    // Store received data byte
);

    logic [1:0] state;         
    logic [7:0] temp;          
    logic [2:0] count;        
    
    // State encoding
    parameter IDLE  = 2'b00;   
    parameter START = 2'b01;  
    parameter DATA  = 2'b10;
    parameter STOP  = 2'b11;  

    // Sampling clock from Baud Rate Generator
    logic s_clk;               
    Baud_rate_generator B (
        .clk_100MHz(clk_100MHz),
        .rst(rst),
        .s_clk(s_clk)
    );   

    // Main UART Receiver FSM
    always_ff @(posedge s_clk, posedge rst) begin
        if (rst) begin
            state   <= IDLE;
            Rx_done <= 0;
            Dout    <= 0;
            temp    <= 0;
            count   <= 0;
        end
        else begin
            case (state)

                IDLE: begin
                    Rx_done <= 1;         // Indicate reciever is ready for recieving new data
                    if (!Rx) begin         // Start bit detected (Rx = 0)
                        state <= START;
                    end
                    else state <= IDLE;    // Keep waiting until any sequence start recieving
                end

                START: begin
                    Rx_done   <= 0;
                    state     <= DATA;     // Move to data next state
                    temp[7]   <= Rx;       // Store first bit in MSB
                    count     <= 1;        // First bit received
                end 

                DATA: begin
                    Rx_done   <= 0;
                    temp      <= temp >> 1; // Shift right to make room for new bit
                    temp[7]   <= Rx;        // Store new bit in MSB
                    count     <= count + 1;
                    if (count == 3'd7)      // 8 bits received
                        state <= STOP;      // Move to next state
                end
                
                STOP: begin
                    Dout    <= temp;       // Output the received byte
                    Rx_done <= 1;          // Signal that reception is complete
                    count   <= 0;          // Reset bit counter
                    state   <= IDLE;       // Go back to IDLE and wait for next sequence
                end
            endcase
        end   
    end         

endmodule
