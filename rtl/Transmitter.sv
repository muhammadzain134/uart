`timescale 1ns / 1ps

module Transmitter (
    input  logic clk_100MHz,   // 100 MHz system clock
    input  logic rst,          // Asynchronous reset
    input  logic Tx_en,        // Transmit enable signal
    input  logic [7:0] Din,    // Parallel data to send
    output logic Tx_done,      // High when transmission is complete
    output logic Tx            // UART serial output line
);

    logic [1:0] state;         
    logic [7:0] temp;          
    logic [2:0] count;         

    // State encoding
    parameter IDLE  = 2'b00;   
    parameter START = 2'b01;   
    parameter DATA  = 2'b10;   
    parameter STOP  = 2'b11;   

    // Baud rate sampling clock
    logic s_clk;          
    Baud_rate_generator B (
        .clk_100MHz(clk_100MHz),
        .rst(rst),
        .s_clk(s_clk)
    );    

    // Main UART Transmitter FSM
    always_ff @(posedge s_clk, posedge rst) begin
        if (rst) begin
            state    <= IDLE;
            Tx       <= 1;     
            Tx_done  <= 0;
            count    <= 0;
        end
        else begin 
            case (state)
            
                IDLE: begin
                    Tx_done <= 1;         
                    Tx      <= 1;          
                    count   <= 0;
                    if (Tx_en) begin
                        temp  <= Din;      // Load data into shift register
                        state <= START;    // Move to next state
                    end
                    else state <= IDLE;    // Wait until Tx_en high
                end

                START: begin
                    Tx       <= 0;         // Start bit (logic low)
                    count    <= 0;         
                    Tx_done  <= 0;         
                    state    <= DATA;      // Move to next state
                end

                DATA: begin
                    Tx       <= temp[0];   // Output LSB first
                    temp     <= temp >> 1; // Shift right for next bit
                    count    <= count + 1;
                    Tx_done  <= 0;
                    if (count == 7)        
                        state <= STOP;     // Move to next state
                end

                STOP: begin
                    Tx       <= 1;         
                    Tx_done  <= 1;         // Transmission complete
                    count    <= 0;
                    state    <= IDLE;      // Move back to IDLE state
                end
            endcase
        end
    end      

endmodule
