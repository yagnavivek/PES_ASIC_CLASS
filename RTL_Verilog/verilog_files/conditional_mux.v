module conditional_mux(i0,i1,s,y);
input i0,i1,s;
output y;
assign y=s?i1:i0;
endmodule
