`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: COLLEGE OF VLSI
// Engineer: ABHISHEK KUMAR KUSHWAHA
// 
// Create Date: 04.04.2024 12:18:38
// Design Name: 
// Module Name: counter
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


module counter #(
    parameter WIDTH = 8
)(
    input clk, rst, trigger_i, req_i,
    output [WIDTH-1:0] count_o
);


    reg [WIDTH-1:0] count_q;
    wire [WIDTH-1:0] count_nxt;

    // Sequential Logic: State Register
    always @(posedge clk or posedge rst) begin
        if(rst)
            count_q <= {WIDTH{1'b0}}; // Reset the counter to 0
        else
            count_q <= count_nxt; // Update the counter based on the next value
    end

    // Combinational Logic: Next Value Calculation
    assign count_nxt = req_i ? {{WIDTH-1{1'b0}}, trigger_i} : (count_q + {{WIDTH-1{1'b0}}, trigger_i});

    // Output Logic
    assign count_o = req_i ? count_q : {WIDTH{1'b0}}; // Output the current count value if req_i is asserted, otherwise output 0

endmodule
