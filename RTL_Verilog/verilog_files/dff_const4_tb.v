
`timescale 1ns / 1ps
module dff_const4_tb;
	// Inputs
	reg clk, reset   ;
	// Output
	wire q;

        // Instantiate the Unit Under Test (UUT)
	dff_const4 uut (
		.clk(clk),
		.reset(reset),
		.q(q)
	);

	initial begin
	$dumpfile("dff_const4_tb.vcd");
	$dumpvars(0,dff_const4_tb);
	// Initialize Inputs
	clk = 0;
	reset = 1;
	#3000 $finish;
	end

always #10 clk = ~clk;
always #1547 reset=~reset;
endmodule
