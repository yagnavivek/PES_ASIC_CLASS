
`timescale 1ns / 1ps
module dff_const1_tb;
	reg clk, reset;
	wire q;

	dff_const1 uut (clk,reset,q);

	initial begin
	$dumpfile("dff_const1_tb.vcd");
	$dumpvars(0,dff_const1_tb);
	// Initialize Inputs
	clk = 0;
	reset = 1;
	#3000 $finish;
	end

always #10 clk = ~clk;
always #1547 reset=~reset;
endmodule
