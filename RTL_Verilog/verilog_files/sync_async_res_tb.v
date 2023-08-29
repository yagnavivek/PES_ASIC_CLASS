`timescale 1ns / 1ps
module sync_async_res_tb;
reg clk,d,ares,sres;
wire q;
sync_async_res sasyncresuut(clk,d,sres,ares,q);
initial begin
	$dumpfile("sync_async_res_tb.vcd");
        $dumpvars(0,sync_async_res_tb);
        clk=0;
	sres=1;
        ares=0;
        d=0;
        #240 $finish;
end
always #10 clk = ~clk;
always #15 ares = ~ares;
always #15 sres = ~sres;
always #40 d = ~d;
endmodule

