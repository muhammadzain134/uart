`timescale 1ns / 1ps

module Transmitter_tb;
logic clk_100MHz;
logic rst;
logic Tx_en;
logic [7:0] Din;
logic Tx_done;
logic Tx;

Transmitter uut (.clk_100MHz(clk_100MHz),.rst(rst),.Tx_en(Tx_en),.Din(Din),.Tx_done(Tx_done),.Tx(Tx));

initial clk_100MHz = 0;
always #5 clk_100MHz = ~clk_100MHz;

initial begin
        rst = 1;
        Tx_en = 0;
        Din = 8'h00;

        #60;
        rst = 0;
        #60;
 
        Din = 8'b1010_0101;  // Data to transmit
        Tx_en = 1;   // Start TX
        #200000;      
        Tx_en = 0;
           
        #1600_000;  
         $finish;       
       
    end

endmodule


