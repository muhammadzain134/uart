`timescale 1ns / 1ps

module UART_tb;

    // Testbench signals
    logic clk_100MHz;     // 100 MHz system clock
    logic rst;            // Reset
    logic Tx_en;          // Transmit enable signal
    logic [7:0] Din;      // Data byte to transmit
    logic Tx_done;        // Transmit complete flag
    logic Tx;             // UART transmit line
    logic Rx;             // UART receive line
    logic Rx_done;        // Receive complete flag
    logic [7:0] Dout;     // Data byte received

    
    UART uut (
        .clk(clk_100MHz),
        .rst(rst),
        .Tx_en(Tx_en),
        .Din(Din),
        .Rx(Rx),           
        .Tx_done(Tx_done),
        .Tx(Tx),
        .Rx_done(Rx_done),
        .Dout(Dout)
    );

    // Clock generation: 100 MHz => 10 ns period
    initial clk_100MHz = 0;
    always #5 clk_100MHz = ~clk_100MHz;  

    
    initial begin
        rst = 1;           
        #60;               
        rst = 0;           
        #100;

        Tx_en = 0;
        Din = 8'h00;
        Rx = 1;            

        // Receiving first byte
        // UART bit period = 104150 ns (for ~9600 baud)
        #104150;           
        Rx = 0; #104150;   // Start bit
        Rx = 1; #104150;   // Bit 0 (LSB first)
        Rx = 1; #104150;   // Bit 1
        Rx = 1; #104150;   // Bit 2
        Rx = 0; #104150;   // Bit 3
        Rx = 1; #104150;   // Bit 4
        Rx = 1; #104150;   // Bit 5
        Rx = 1; #104150;   // Bit 6
        Rx = 0; #104150;   // Bit 7 (MSB)
        Rx = 1; #104150;   // Stop bit

  
        #104150;           
        #104150;

        //  Receiving second byte
        Rx = 0; #104150;   // Start bit
        Rx = 1; #104150;   // Bit 0
        Rx = 0; #104150;   // Bit 1
        Rx = 1; #104150;   // Bit 2
        Rx = 0; #104150;   // Bit 3
        Rx = 1; #104150;   // Bit 4
        Rx = 1; #104150;   // Bit 5
        Rx = 1; #104150;   // Bit 6
        Rx = 0; #104150;   // Bit 7
        Rx = 1; #104150;   // Stop bit

        
        #4000_000;

        //  Test UART transmission 
        Din = 8'b1010_0101; // Data to transmit
        Tx_en = 1;          // Start TX
        #200000;            
        Tx_en = 0;          

        // Wait for transmission to complete
        #1600_000;  

        $finish;            
    end

endmodule
