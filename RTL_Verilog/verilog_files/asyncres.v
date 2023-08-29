`timescale 1ns / 1ps
module asyncres(clk,d,ares,q);
input clk,d,ares;
output reg q;
always @(posedge clk or posedge ares)
begin
	if(ares)
		q<=1'b0;
	else
		q<=d;
end
endmodule
