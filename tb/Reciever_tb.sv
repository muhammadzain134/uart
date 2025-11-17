`timescale 1ns / 1ps

module Reciever_tb;
logic clk_100MHz;
logic rst;
logic Rx;
logic Rx_done;
logic [7:0] Dout;

Receiver uut (.clk_100MHz(clk_100MHz),.rst(rst),.Rx(Rx),.Rx_done(Rx_done),.Dout(Dout));

initial clk_100MHz = 0;
always #5 clk_100MHz = ~clk_100MHz;

initial begin
    rst = 1;
    #20
    rst = 0;
    Rx =1;
    #104150;
    Rx = 0; #104150;  // Start bit
    Rx = 1; #104150;  // Data bit 1
    Rx = 1; #104150;  // Data bit 2
    Rx = 1; #104150;  // Data bit 3
    Rx = 0; #104150;  // Data bit 4
    Rx = 1; #104150;  // Data bit 5
    Rx = 1; #104150;  // Data bit 6
    Rx = 1; #104150;  // Data bit 7
    Rx = 0; #104150;  // Data bit 8
    Rx = 1; #104150;  // Stop bit
    #104150 ;
    #104150;
    Rx = 0; #104150;  // Start bit
    Rx = 1; #104150;  // Data bit 1
    Rx = 0; #104150;  // Data bit 2
    Rx = 1; #104150;  // Data bit 3
    Rx = 0; #104150;  // Data bit 4
    Rx = 1; #104150;  // Data bit 5
    Rx = 1; #104150;  // Data bit 6
    Rx = 1; #104150;  // Data bit 7
    Rx = 0; #104150;  // Data bit 8
    Rx = 1; #104150;  // Stop bit
    #4000_000 ;
    $finish;
end
endmodule
