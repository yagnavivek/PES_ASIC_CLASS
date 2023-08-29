
`timescale 1ns / 1ps
module conditional_mux_tb;
	// Inputs
	reg i0,i1,s;
	// Outputs
	wire y;

        // Instantiate the Unit Under Test (UUT)
	conditional_mux uut (
		.s(s),
		.i0(i0),
		.i1(i1),
		.y(y)
	);

	initial begin
	$dumpfile("conditional_mux_tb.vcd");
	$dumpvars(0,conditional_mux_tb);
	// Initialize Inputs
	s = 0;
	i0 = 0;
	i1 = 0;
	#300 $finish;
	end

always #75 s = ~s;
always #10 i0 = ~i0;
always #55 i1 = ~i1;
endmodule
