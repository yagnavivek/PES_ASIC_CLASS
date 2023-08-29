`timescale 1ns / 1ps
module submodule1(input a , input b , output y);
 assign y = a & b;
endmodule


module submodule2(input a , input b , output y);
 assign y = a^b;
endmodule


module multiple_modules_opt(input a , input b , input c , input d , output y);
wire n1,n2,n3;

submodule1 sub1 (a,1,n1);
submodule2 sub20 (n1,0,n2);
submodule2 sub21 (b,d,n3);

assign y = c | (b & n1);


endmodule
