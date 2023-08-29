module submodule1(a,b,y);
input a,b;
output y;
assign y=a&b;
endmodule

module submodule2(a,b,y);
input a,b;
output y;
assign y=a|b;
endmodule

module multiple_modules(a,b,c,y);
input a,b,c;
output y;
wire mid;
submodule1 sub_and(a,b,mid);
submodule2 sub_or(mid,c,y);
endmodule
