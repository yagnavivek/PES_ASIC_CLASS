`timescale 1ns / 1ps
module asyncset(clk,d,aset,q);
input clk,d,aset;
output reg q;
always @(posedge clk or posedge aset)
begin
        if(aset)
                q<=1'b1;
        else
                q<=d;
end
endmodule

