
`timescale 1ns / 1ps
module blocking_error_tb;
	// Inputs
	reg a,b,c   ;
	// Output
	wire d;

        // Instantiate the Unit Under Test (UUT)
	blocking_error uut (
		.a(a),
		.b(b),
		.c(c),
		.d(d)
	);

	initial begin
	$dumpfile("blocking_error_tb.vcd");
	$dumpvars(0,blocking_error_tb);
	// Initialize Inputs
	a = 0;
	b = 0;
	c = 0;
	#3000 $finish;
	end

always #10 a = ~a;
always #100 c =~c;
always #50 b = ~b;
endmodule
