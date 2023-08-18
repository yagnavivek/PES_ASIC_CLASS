.section .text
.global load
.type load, @function

//load x and y into a0,a1

load: 
	add	a4,a0,zero 	//initialise result register a4 with zero
	add 	a2,a0,a1 	// store count of 10 in register a2. Register a1 is loaded with 0xA from main
	add 	a3,a0,zero 	//initialise intermediate result register a3 by 0
loop:	
	add 	a4,a3,a4	//incremental addition
	addi 	a3,a3,1		//increment intermediate register by 1
	blt 	a3,a2,loop	//if a3<a2, branch to <loop>
	add	 a0,a4,zero	//store final result to register a0 so that it can be read by main process
	ret
