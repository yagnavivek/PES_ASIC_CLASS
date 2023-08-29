`timescale 1ns / 1ps
module asyncset_tb;
reg clk,d,aset;
wire q;
asyncset asyncsetuut(clk,d,aset,q);
initial begin
	$dumpfile("asyncset_tb.vcd");
        $dumpvars(0,asyncset_tb);
        clk=0;
        aset=0;
        d=0;
        #120 $finish;
end
always #15 clk = ~clk;
always #20 aset = ~aset;
always #40 d = ~d;
endmodule

