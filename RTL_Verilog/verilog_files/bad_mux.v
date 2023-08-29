module bad_mux(i0,i1,s,y);
input i0,i1,s;
output reg y;
always @(s)
begin
	if(s)
		y<=i1;
	else
		y<=i0;
end
endmodule
