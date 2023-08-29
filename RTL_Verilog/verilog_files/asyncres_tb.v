`timescale 1ns / 1ps
module asyncres_tb;
reg clk,d,ares;
wire q;
asyncres asyncresuut(clk,d,ares,q);
initial begin
	$dumpfile("asyncres_tb.vcd");
	$dumpvars(0,asyncres_tb);
	clk=0;
	ares=0;
	d=0;
	#120 $finish;
end
always #15 clk = ~clk;
always #20 ares = ~ares;
always #40 d = ~d;
endmodule	
