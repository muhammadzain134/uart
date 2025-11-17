`timescale 1ns / 1ps

module UART(
    input  logic clk,      // 100 MHz main clock
    input  logic rst,      // synchronous reset
    input  logic Tx_en,    // start TX
    input  logic [7:0] Din,// TX data
    input  logic Rx,       // RX serial in
    output logic Tx_done,  // TX done flag
    output logic Tx,       // TX serial out
    output logic Rx_done,  // RX done flag
    output logic [7:0] Dout  // RX parallel out
);
    // Instantiate Transmitter
    Transmitter tx (
        .clk_100MHz(clk),
        .rst(rst),
        .Tx_en(Tx_en),
        .Din(Din),
        .Tx_done(Tx_done),
        .Tx(Tx)
    );
    
    // Instantiate Transmitter
    Receiver rx (
        .clk_100MHz(clk),
        .rst(rst),
        .Rx(Rx),
        .Rx_done(Rx_done),
        .Dout(Dout)
    );

endmodule
