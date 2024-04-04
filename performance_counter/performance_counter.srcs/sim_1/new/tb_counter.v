`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: COLLEGE OF VLSI
// Engineer: ABHISHEK KUMAR KUSHWAHA
// 
// Create Date: 04.04.2024 12:41:33
// Design Name: 
// Module Name: tb_counter
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


module tb_counter;

    // Parameters
    parameter WIDTH = 8;

    // Inputs
    reg clk ;
    reg rst ;
    reg trigger_i;
    reg req_i;

    // Outputs
    wire [WIDTH-1:0] count_o;

    // Instantiate the counter module
    counter #(
        .WIDTH(WIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .trigger_i(trigger_i),
        .req_i(req_i),
        .count_o(count_o)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin

        // Reset
        rst = 1;
        trigger_i = 0;
        req_i = 0;
        #10 rst = 0;

        // Test case 1: Normal counting after req_i high for one pulse.
        #20;
        @(posedge clk);
        req_i = 0;
        trigger_i = 1;
        @(posedge clk);
        trigger_i = 1;
        @(posedge clk);
        trigger_i = 0;
//        @(posedge clk);
        req_i = 1;
        @(posedge clk);
        req_i = 0;
        // Test case 2: Counting with req_i high for one pulse and deasserted with trigger.
        #20;
        @(posedge clk);
        trigger_i = 1;
        @(posedge clk);
        trigger_i = 1;
        req_i = 1;
        @(posedge clk);
        trigger_i = 0;
        req_i = 0;
        // Test case 2: Counting with req_i high for long pulse and deasserted trigger after one pulse.
        #20;
        @(posedge clk);
        trigger_i = 1;
        req_i = 1;
        @(posedge clk);
        req_i = 1;
        trigger_i = 0;
        #100;
        @(posedge clk);
        req_i = 0;
        // End simulation
        #100 $finish;
    end

endmodule

