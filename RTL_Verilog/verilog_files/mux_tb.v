`timescale 1ns / 1ps

module mux_tb;
reg i0,i1,s;
wire y;

mux uut(i0,i1,s,y);

initial begin
	$dumpfile("mux_tb.vcd");
	$dumpvars(0,mux_tb);
	i0=0;i1=0;s=0; #100 $finish;end

always #10 i0 = ~i0;
always #20 i1 = ~i1;
always #40 s = ~s;

endmodule	
