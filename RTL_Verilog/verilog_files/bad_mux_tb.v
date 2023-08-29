

`timescale 1ns / 1ps
module bad_mux_tb;
	// Inputs
	reg i0,i1,s;
	// Outputs
	wire y;

        // Instantiate the Unit Under Test (UUT)
	bad_mux uut (
		.s(s),
		.i0(i0),
		.i1(i1),
		.y(y)
	);

	initial begin
	$dumpfile("bad_mux_tb.vcd");
	$dumpvars(0,bad_mux_tb);
	// Initialize Inputs
	s = 1'b0;
	i0 = 1'b0;
	i1 = 1'b0;
	#300 $finish;
	end

always #75 s = ~s;
always #10 i0 = ~i0;
always #55 i1 = ~i1;
endmodule
