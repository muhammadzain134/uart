`timescale 1ns / 1ps

module Baud_rate_generator #(
    parameter BAUD_DIV = 5208
)(
    input  logic clk_100MHz,
    input  logic rst,       
    output logic s_clk  
);

    logic [20:0] count;

    always_ff @(posedge clk_100MHz,posedge rst) begin
        if(rst) begin
            count <= 0;
            s_clk <= 0;
        end
        else if(count == BAUD_DIV - 1) begin
            s_clk <= ~s_clk;
            count <= 0;
        end
        else begin
            count <= count + 1;
        end
    end

endmodule
