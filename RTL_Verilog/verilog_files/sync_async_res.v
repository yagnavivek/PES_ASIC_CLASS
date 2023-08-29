`timescale 1ns / 1ps
module sync_async_res(clk,d,sres,ares,q);
input clk,d,sres,ares;
output reg  q;

always @(posedge clk ,posedge ares)
begin
	if(ares)
		q<=1'b0;
	else if(sres)
		q<=1'b0;
	else
		q<=d;
end
endmodule

