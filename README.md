# PES_ASIC_CLASS
This Repository Guides you to complete ASIC flow from scratch (FACULTY : Mahesh Awati, GUIDE : Kunal Ghosh)

## The COURSE files are present under those respective day folders 

### Solutions to frequenty occuring errors are in Error_solution.md

## Install the Prerequisites(for ubuntu)

```
sudo apt update
sudo apt upgrade
chmod +x run_ubuntu.sh
./run_ubuntu.sh
```
The installed contents will be available at ~/riscv_toolchain

# Introduction
### Flow : HLL -> ALP -> Binary -> (HDL) -> GDS
#### 1. HLL -> High level language (c , c++) 
- A high-level programming language is a type of programming language that is designed to be more human-readable and user-friendly compared to low-level languages like assembly or machine code.

#### 2. ALP -> Assembly level program
- Assembly language is a low-level programming language that is closely related to the architecture of a specific computer's central processing unit (CPU). Assembly language programs are written using mnemonic codes that represent specific machine instructions which the machine can understand.

#### 3. HDL -> Hardware Description Language
- It is a specialized programming language used for designing and describing digital hardware circuits. HDLs allow engineers to model and simulate complex digital systems before physical implementation, aiding in the design and verification of integrated circuits and FPGA configurations.
- Verilog, System Verilog, VHDL

#### 4. GDS -> Graphic Data System (layout)
- Format used in the semiconductor industry to represent the layout and design of integrated circuits at a highly detailed level. GDSII files contain information about the geometric shapes, layers, masks, and other essential details that make up the physical layout of a chip.
- Tools : Klayout, Magic

##### The Hardware needs to understand what the Application software is saying it to do.This relation can be eshtablished by System Software

____System Software____
- OS : Operating System : Handles IO, memory allocation, Low level system function
- Compiler : Convert the input to hardware dependent instruction
- Assembler : Convert the instructions provided by compiler to Binary format
- HDL : A program that understands the Binary pattern and map it to a netlist
- GDS : Layout

# COURSE 
<details>
<summary>DAY 1: Introduction to RISCV ISA and GNU Compiler Toolchain</summary>
<br>

## Introduction to Risc-v Basic Keywords
- **Instruction Set Architecture(ISA)**
  - An Instruction Set Architecture (ISA) refers to the set of instructions that a computer's central processing unit (CPU) can understand and execute. It defines the interface between software and hardware, specifying the operations that a CPU can perform, the data types it can manipulate, and the memory addressing modes it supports.

- **Risc-V ISA**
  - Risc-V ISA is an open-source ISA that has simpler and fixed length instructions that allows us to create custom processors for specific needs without being tied to proprietary architectures
 
- **Tools Used for the flow**
  - As we are aware of the flow, we will be using Risc-v ISA ALP and the RTL used will be picorv32a (We will be using rv64i during initial stages)

# Goal : Any High level Program that is written should be able to get executed in our CHIP

### List of well-known extensions present in Risc-V ISA

``` rv32i``` ``` rv64i``` ```rv32imc``` ```rv64imc``` ```rv32imafdc``` ```rv64imafdc``` ```rv32imcb``` ```rv64imcb``` ```rv32imc_sv32``` ```rv64gcv```

### Extensions and their Applications

- **I (Integer)** :The I set includes the base integer instruction set for RISC-V. It provides fundamental integer arithmetic and logical operations, data movement, and control flow instructions.
  - ADD, SUB, AND, OR, XOR, ADDI, SLTI, JAL, BEQ, LW

- **M (Multiply and Divide)** : The M set adds integer multiplication and division instructions to the base integer set. These instructions are particularly useful for arithmetic-heavy computations.
  - MUL, MULH, DIV, REM
  
- **A (Atomic)** : The A set introduces atomic memory access instructions. These instructions enable multiple operations on memory locations to be performed atomically, ensuring that other processors or threads cannot observe intermediate states.
  - LR (Load-Reserved), SC (Store-Conditional), AMO (Atomic Memory Operation)
  
- **F (Single-Precision Floating-Point)**: The F set adds single-precision floating-point instructions. These instructions enable arithmetic operations on 32-bit floating-point numbers.
  - FADD.S, FSUB.S, FMUL.S, FDIV.S, FCVT.W.S, FCVT.S.W

- **D (Double-Precision Floating-Point)** : The D set includes double-precision floating-point instructions. These instructions allow arithmetic operations on 64-bit floating-point numbers.
  - FADD.D, FSUB.D, FMUL.D, FDIV.D, FCVT.W.D, FCVT.D.W

- **C (Compressed)** : The C set introduces a compressed instruction format that reduces the size of code. Compressed instructions maintain the same functionality as their non-compressed counterparts but use shorter encodings.
  - C.ADDI4SPN, C.LWSP, C.ADDI, C.SW, C.JALR, C.BEQZ

- **G (Atomic and Lock-Free Operations)** : The G set, also known as the "GAS Set," is an alternative to the A set. It focuses on providing atomic and lock-free instructions to simplify hardware implementation.
  - LRV (Load-Reserved Variant), SCV (Store-Conditional Variant), AMO (Atomic Memory Operation Variants)

- **V (Vector)** :The V set adds vector instructions to the ISA, enabling Single Instruction, Multiple Data (SIMD) operations. These instructions allow efficient parallel processing of data elements in vectors.
  - VADD, VMUL, VFMADD, VLW, VSW

- **S (Supervisor)** : The S set, often used in privileged modes, includes instructions for managing and interacting with the supervisor-level operations of the system, such as handling exceptions and interrupts.
  - ECALL, EBREAK, SRET, MRET, WFI

- **B (Bit Manipulation)** : The B set introduces instructions for bit manipulation operations, allowing efficient manipulation of individual bits in registers and memory.
  - ANDI, ORI, XORI, SLLI, SRLI, SRAI

## 1. Create a simple C program That calculates sum from 1 to N -> sum_1_to_N.c

_____Compile it using C compiler_____
```
gcc sum_1_to_N.c -o 1_to_N.o
./1_to_N.o
```
-o allows you to name your output file

![compile_using_c_compiler](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/484cbdf8-07db-41b7-bc1b-6667825d580f)

_____compile using riscv compiler and view the output_____
```
riscv64-unknown-elf-gcc -O1 -mabi=lp64 -march=rv64i -o 1_to_N.o sum_1_to_N.c
spike pk 1_to_N.o
```

![compile_using_riscv](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/adee1aab-d1da-44e3-8bad-babf43f869af)

- ```-O<number>``` : level of optimisation required
- ```-mabi``` : specifies the ABI (Application Binary Interface) to be used during code generation according to the requirements
- ```-march``` : specifies target architecture

_______We can check the different options available for all these fields using the commands_______ 
go to the directory where riscv64-unkonwn-elf is present
- -O1 : ``` riscv64-unkonwn-elf --help=optimizer```
- -mabi : ```riscv64-unknown-elf-gcc --target-help```
- -march : ```riscv64-unknown-elf-gcc --target-help```

_____To view the disassembled ALP code_____
```
riscv64-unknown-elf-objdump -d 1_to_N.o
```

_____To debug the ALP generated by the compiler_____
```
spike -d pk 1_to_N.o
```
![debug_using_spike](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/472dc533-af76-4b07-bb53-8fa8e2100785)

- press ENTER : shows the first line and successive ENTER shows successive lines
- reg 0 a2 : checks content of register a2 0th core
- q : quit the debug process

##### Difference between the ALP commands when used different optimizers
- use the command ```riscv64-unknown-elf-objdump -d 1_to_N.o | less```
- use ``` /instance``` to search for an instance 
- press ENTER
- press ```n``` to search next occurance
- press ```N``` to search for previous occurance. 
- use ```esc :q``` to quit

_____Contents of main when used -O1 optimizer_____
![ALP_used_O1](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/9c63218d-babc-45df-bb62-c894b27f13c5)

_____contents of main when used -Ofast optimizer_____
![ALP_Used_ofast](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/a89dff4b-30a7-46fe-bd7e-166ebe95f4e9)

## Integer number Representation (n-bit)
- Range of Unsigned numbers : [0, (2^n)-1 ]
* Range of signed numbes : Positive : [0 , 2^(n-1)-1]
                         Negative : [-1 to 2^(n-1)]

## 2. create a C program that shows the maximum and minimum values of 64bit unsigend and signed numbers

```
sign_unsign.c
```
![sign_snsign_compiled](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/99db1c71-f02f-472e-9185-4684a90551b8)

[Back to COURSE](https://github.com/yagnavivek/PES_ASIC_CLASS/tree/main#course)

</details>
<details>
<summary>DAY 2 : Introduction to ABI and Basic Verification Flow </summary>
<br>

## BASICS :

Instructions that act on signed or unsigned integers are called Base Integer Instructions
There are 47 Base Integer Instructions present in RISC-V ISA

### Types of Instruction based on encoding format

1. **R-Type (Register-Type):**
   - These instructions operate on registers and have a fixed format for their operands.
   - Examples: ADD, SUB, AND, OR, XOR, SLL, SRL, SRA, SLT, SLTU

2. **I-Type (Immediate-Type):**
   - These instructions have an immediate operand and one register operand.
   - Examples: ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI, LB, LH, LW, LBU, LHU, JALR

3. **S-Type (Store-Type):**
   - These instructions are used for storing values from registers to memory.
   - Examples: SB, SH, SW

4. **B-Type (Branch-Type):**
   - These instructions perform conditional branching based on comparisons.
   - Examples: BEQ, BNE, BLT, BGE, BLTU, BGEU

5. **U-Type (Upper Immediate-Type):**
   - These instructions have a larger immediate field for encoding larger constants.
   - Examples: LUI, AUIPC

6. **J-Type (Jump-Type):**
   - These instructions are used for unconditional jumps and function calls.
   - Examples: JAL

<img width="1000" height="420" alt="image" src="https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/e69043fb-684e-42eb-9e21-fd51943c1ec1">

**[number]** represents number of bits occupied by that field

1. **Opcode [7] :** The opcode is a field within a machine language instruction that indicates the operation to be performed by the instruction. It defines the type of operation, such as arithmetic, logic, memory access, or control flow. Opcodes are used by the CPU to determine how to execute the instruction.

2. **rd (Destination Register) [5]:** The "rd" field represents the destination register in an assembly language instruction. It indicates the register where the result of the operation will be stored. After executing the instruction, the computed value will be placed in this register.

3. **rs1 (Source Register 1) [5]:** The "rs1" field represents the first source register in an assembly language instruction. It indicates the register that holds the value used in the operation. For instructions that involve two operands, "rs1" typically corresponds to the first operand.

4. **rs2 (Source Register 2) [5]:** The "rs2" field represents the second source register in an assembly language instruction. It indicates the register that holds the value used in the operation. For instructions that involve three operands, "rs2" typically corresponds to the second operand.

5. **func7 and func3 (Function Fields)[7] [3]:** These fields further refine the operation specified by the opcode. The "func7" field is used to distinguish different variations of instructions within the same opcode category. The "func3" field is used to specify a more specific operation within the opcode category. Together, these fields allow for a finer level of instruction differentiation.

6. **imm (Immediate Value):** The "imm" field represents an immediate value that is part of the instruction. Immediate values are constants that are embedded within the instruction itself. They can be used for various purposes, such as specifying offsets, constants, or small data values directly within the instruction.


#### ABI : Application Binary Interface

The instructions generated by compiler using a target ISA can be accessed by OS and User directly
- The parts of ISA accessible to User : User ISA
- The parts of ISA accessible to OS : system ISA
The access is done using Sysytem calls with the help of ABI

==> If we want to access hardware resources of processor, it has to be done via registers using ABI(names)

### ABI Names : 
- ABI names for registers serve as a standardized way to designate the purpose and usage of specific registers within a software ecosystem. These names play a critical role in maintaining compatibility, optimizing code generation, and facilitating communication between different software components.

<img width="1000" height="600" src="https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/27d13974-1b70-4207-a2fb-05b232027323">

#### Data can be stored in register by 2 methods
1. Directly store in registers
2. Store into registers from memory

To store 64 bits of data from mem to reg, we use 8*8bit stores ie., m[0],m[1]......m[7]. 

- ___RISC-V uses Little Endian format to store the data ie., Least significant Byte is stored in m[0]___

## Simulate a C program using ABI function call (using registers) and execute 

The required program files are under day 2 folder

<img width="1150" height="150" src="https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/45c24570-4f59-4ddc-8a15-741bdd2d18c2">

![alp_onetonextern](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/c6e76147-0b45-4699-8f09-ea20e0364a47)

Here we can observe that at 5th line, inorder to comute the result ,its going to the "load"  function

### Further we will see how to run a C program on on RISC-V CPU

- Input : C Program loaded into memory to RISC-V CPU in Hex format

CPU processes the contents of the memory and provides with output using iverilog 

- Risc-V CPU : ```Picorv32.v```
- Testbench for verification : ```testbench.v```
- Tool : ```iverilog```
- script : ```rv32im.sh``` : has the commands to get the c-program, ALP, converts into hex format, loads into memory of riscv cpu, passes it iverilog and provides the output

![Screenshot from 2023-08-21 22-22-08](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/e2f64a4f-e83a-4c2c-a273-124f56b4da8b)


[Back to COURSE](https://github.com/yagnavivek/PES_ASIC_CLASS/tree/main#course)
</details>

#  RTL design using Verilog with SKY130 Technology 

<details>
<summary>DAY 1:Introducton to Verilog RTL Design and Sythesis</summary>
<br>

## Prerequisites installation

Tools Required : gtkwave , iverilog , Yosys
```
sudo apt update
sudo apt upgrade
sudo apt-get install gtkwave
git clone https://github.com/YosysHQ/yosys.git
cd yosys
sudo apt install make
sudo apt-get install build-essential clang bison flex  libreadline-dev gawk tcl-dev libffi-dev git  graphviz xdot pkg-config python3 libboost-system-dev libboost-python-dev libboost-filesystem-dev zlib1g-dev
make config-gcc
make -j 4
```
#### Note: for iverilog installation, follow the corresponding part under "run_ubuntu.sh" file under files section

- **Yosys:** Yosys is an open-source synthesis tool that converts RTL (Register Transfer Level) descriptions written in HDL (Hardware Description Language) into optimized gate-level netlists for digital circuit designs.
	-Inputs to yosys : liberty file(.lib) and design file(HDL)
	-Output : synthesized netlist mapped with the provided technology library

- **Iverilog:** Iverilog is an open-source Verilog simulation and synthesis tool that allows designers to verify their digital designs using simulation and generate netlists for synthesis.
	-Inputs to iverilog : testbench and design files
	-output : VCD (Value change dump) file that stores data related to simulation

- **GTKWave:** GTKWave is an open-source waveform viewer that provides graphical visualization of simulation results produced by digital design simulation tools, aiding in the debugging and analysis of digital circuits.
	-Inputs : VCD FIle
	-output : Simulation waveform

### Terminologies

- **Simulator** : The RTL should be check if it matches with the specifications provided. This work is done by Simulator and is used to simulate the design for its functionality
	- Example : iverilog
	- Simulator looks for a change in input, based on which the output is evaluated ==> if there is no change in input, Then output is not evaluated.

- **Design** : The set of verilog code(s) that represents the provided functionality/Specification in the form of a netlist.

- **Testbench** : Setup to apply stimulus(test vectors)to the design inorder to check the functionality using the response obtained.
	- The response is obtained using iverilog in the form of VCD file that is visulaised using gtkwave

- **Synthesizer** : Tool required t convert RTL to netlist
	- Example : yosys

- **Netlist** : In Synthesis, RTL Design is converted to gate level netlist ie.,design is converted into gates and connections are made between the gates. This is givenout as a file called netlist.

- **liberty(.lib)** : It contains all cells required to represent any logic and the cells are of different flavours(different power, delay, operating conditions etc) 
 

#### Files : 

1. The liberty file required for synthesis is ```sky130_fd_sc_hd__tt_025C_1v80.lib``` present under ```RTL_Verilog``` Folder
2. The Design Files can be found under ```verilog_files``` folder inside ```RTL_verilog``` folder

### Simulation and Results

- create a simple design file ```mux.v```
- write a testbench for it ```mux_tb.v```
- To check for functionality, follow the below steps
```
cd /path/to/file/location
iverilog mux.v mux_tb.v -o mux.out
./mux.out
gtkwave mux_tb.vcd
```

The generated waveform can be viewed after appending the nets into signals tab and zoom the waveform to fit the window and the response to stimulus can be observed.

![mux_gtk](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/1bc3db0d-d276-4410-8a38-21af17dcaefd)

### Synthesis and Results

- To synthesize an RTL, as discussed earlier, we need .lib, .v files which provide a mapped.v file as output.
- To check if synthesis is successful, we have to perform post-synthesis simulation whose output should match with results of pre-synthesis simulation

### Some Important Points :

- Every Liberate file has different flavours of cells such as slow,fast and typical.
- Why fast cells? : Speed of the circuit can be increased only when combinational block delay is less.Therefore we need fast working cells
- why slow cells? : If the combinational block provides output very fast, then it becomes harder for the next combinational block to process the signal. Therefore we use slow cells to balance the delay.(ENsure no HOLD issues)
- Faster cells and slower cells are differentiated based on the rate of charging and discharging
- higher the rate, lesser the delay. This can be done when we can source more current through the transistors that is achieved by widening the transistors.
- Wider transistor : Low Delay : More area : More power
- Narrow transistors : Larger delay : Less area : Less power

Therofore, to achieve optimal syntheis result, we have to specify constraints to the synthesizer that says which set of cells to be selected for syntheis process.

## Synthesis (Interactive flow)

1. open yosys where the verilog files are present using the command  - ```yosys```
2. Specify the technology library to be used - ```read_liberty -lib <PATH_TO_.lib_FILE_LOCATION>/sky130_fd_sc_hd__tt_025C_1v80.lib```
3. specify all the verilog files to be synthesized - ```read_verilog mux.v```
4. since some designs have submodules, it is necessary to mention the topmodule name (mux in my case) - ```synth -top mux```
5. Generate synthesized netlist (ABC links the expression declared in design file with cells present in library) - ```abc -liberty <Path_to_.lib_File>/sky130_fd_sc_hd__tt_025C_1v80.lib```
6. To view the graphical representation of sytnthesized netlist - ```show```
7. Write the generated netlist into a verilog file - ```write_verilog mux_mapped.v``` or ```write_verilog -noattr mux_mapped.v```
	- noattr helps in compressing the mapped netlist by removing unwanted information

#### ABC Statistics for the synthesis process
![abc_mux_statistics](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/bb47209f-5509-48cd-a1fc-c193509dcd9a)

![mux_statistics](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/7e187c05-d920-4980-a5e5-200edb12075a)

#### Netlist
![mux_show](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/a3f056e4-88fa-4263-a8cf-72f7a05971c3)

#### Mapped file when used "-noattr" switch
![mapped_mux](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/e8cbbdd5-89ef-4409-a3b9-03c48e753a8b)

#### Mapped file when the above switch not used
![mux_mapped_without_noattr](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/c5d1fc43-f684-452b-b44b-ec398247087d)

The difference tells that when switch is used, un-necessary syntax is removed and the file is written in a compact form

[Back to COURSE](https://github.com/yagnavivek/PES_ASIC_CLASS/tree/main#course)

</details>

<details>
<summary>DAY 2: Timing libs, Efficient flop coding styles</summary>
<br>

## Liberate file explained 

lib file name : sky130_fd_sc_hd__tt_025C_1v80.lib
- ```tt`` - Typical PMOS typical NMOS (Regular working speed)
- ```025C``` - Temperature
- ```1v80``` - supply voltage
The above 3 parameters shortly known as PVT(Process Voltage Temperature) define how and at what conditions the fabricated silicon works
- ```sky130``` - 130nm Technology node
- ```fd``` - Foundry design
- ```sc``` - standard cell
- ```hd``` - high density - This specifies that this library supports using these standard cells at a high density resulting in samller chip area

- The library file consists of all the details of the cell ie., leakage power, area, timing etc. for all input combinations
- The library file consists of some same cell with different loads that facilitate the synthesis process.

![and201](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/36923763-9654-4ad0-9230-8d038f1a7332)

-From the figure, it is clear that we have different flavours of same cells whose values are different.

### Hierarchical Synthesis V/s Flat Synthesis

In Hierarchical synthesis, The hierarchy is maintained ie., submodules will be displayed as submodule block itself.They wont be represented by the logic present inside them but when flattened, the submodule data will not be visible. Only the top module will be visible.

#### Steps for hierarchical synthesis, flat synthesis and submodule level synthesis

```
read_liberty -lib <PATH_TO_.lib_FILE>/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog multiple_modules.v
synth -top multiple_modules  <!-- We can use synth -top <submodule_name> to synthesize the design at submodule level
abc -liberty <PATH_TO_.lib_FILE>/sky130_fd_sc_hd__tt_025C_1v80.lib
write_verilog -noattr multiple_modules_mapped_hier.v
show multiple_modules
flatten
write_verilog -noattr multiple_modules_mapped_flat.v
show multiple_modules
```
### Hierarchical Synthesis output 

![multi_mod_hier](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/47305ca1-3f4a-448b-b648-2745b9662de7)

### Flattened Synthesis netlist

![multi_mod_flat](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/7e1409b5-7514-4cbe-b3a3-38fe7c48b4af)

### Submodule Synthesis netlist (submodule2 in this case)

![submod2](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/38a1776b-6920-4f4e-85a5-7a9ff363e818)

#### Note : 
- While synthesizing OR gate , AND gate, most of the times the tool uses NAND Gates to obtain the functionality as in NAND gates,The NMOS are connected in series and provide better signal transfer.
- Submodule level synthesis helps reduce synthesis time when in a massive design, the same submodule has been called many times and also we can synthesize all submodules and stitch them to obtain top level.But here the optimisation also takes place at submodule level ,not at top level.3

### Flops

Due to propogation delays of gates, The combinational block may output some glitches which might be negligible but when "n" number of combinational blocks are connected, theglich becomes large and no more remains a glitch but as a false state. So to avoid the addition effect of glitches we will have flops at the end of each combinational blocks as the flop stores the final value and the glitch is eliminated before passing it to next block.

Steps to synthesize flops
```
read_liberty -lib <PATH_TO_.lib_FILE>/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog flop.v
synth -top flop
dfflibmap -liberty <PATH_TO_.lib_FILE>/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty <PATH_TO_.lib_FILE>/sky130_fd_sc_hd__tt_025C_1v80.lib
write_verilog -noattr flop_mapped.v
show 
```
To view the waveform
```
iverilog flop.v flop_tb.v -o flop.out
./flop.out
gtkwave flop_tb.vcd
```

## D-flip-flop with an asynchronous reset

![asyncres_stats](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/cef13e93-fc85-47d6-bf81-b1e110d4412c)

Since we see a D Flip FLop getting inferred, We use the above mentioned dfflibmap command to map the flops accurately
View the output waveforms

![asyncres_netlist](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/e3075c6c-714b-42a6-ad99-bde2a7ed3023)

To Check the functionality, We refer to this waveform

![asyncres_wvf](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/0788dc0a-95af-43c5-906d-a8961c6887e0)


## D-flip-flop with an asynchronous set

![asyncset_netlist](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/f448f979-d3d7-4f6a-878c-681a7d4db8c0)

![asyncset_wvf](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/04126806-59a3-4506-8877-c4901e45c592)

## D-flip-flop with both synchronous and asynchronous reset

![sync_async_res_netlist](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/d0368959-6e54-4cd6-a015-683c6e9158f0)

![sync_async_res_wvf](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/5ab8057d-43b6-4d00-9385-46c1ba6279f2)

#########################mul2.v and mul8.v synthesize,explain the reson behing such netlist and paste screenshots of show command################################
## Mul2 

![mul2_full](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/d9ac5584-9c21-4308-ad06-d3c83b936871)

When a number is multiplied by 2, it just means that the number is right shifted once. Therefore a bit "0" is appended at the end of the number to be multiplied by 2. Therefore optimisation has been done by appending a ground bit instead of inferring a multiplier.

## Mul8

![mul8_full](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/fd649cc2-3792-4078-8a4d-95ee9bede0f2)

mul9 is nothing but a(8+1) so append 3 zeroes at end for a and add a .Therefore multiplier is not inferred here and only 3 bits are added.

[Back to COURSE](https://github.com/yagnavivek/PES_ASIC_CLASS/tree/main#course)

</details>

<details>
<summary>DAY 3: Combinational and sequential optimizations</summary>
<br>

## Logic Optimisation

- *Combinational Logic Optimisation*
	- Constant Propogation
	- Boolean logic Optimisation
- *Sequential Logic Optimisation*
	- Sequential constant propogation
	- State optimisation
	- Retiming
	- Sequential logic cloning

#### To perform the combinational logic optimisation, use the command ```opt_clean -purge``` before linking to abc  and synthesize.

##########################################show all 4 ss of netlist and wvf of optcheck, 2 ,3, 4###################################################
###########################################ss of multiple_modules_opt and its wvf ###############################################

Inorder to optimise a verilog files tha has submodules, We have to first flatten it, then optimize and complete the synthesis process

#### To perfor, the sequential logic optimisation, use

#############################################show all 5 ss of netlist and wvf of dff_cost 1 2 3 4 5###############################################

##########################################counter_opt netlist ss and explaination##########################

[Back to COURSE](https://github.com/yagnavivek/PES_ASIC_CLASS/tree/main#course)

</details>

<details>
<summary>DAY 4:GLS, SYnthesis solution mismatch</summary>
<br>

## Gate Level Simulation(GLS)

- used for post-synthesis verification to ensure functionality and timing requirements
- input : testbench ,synthesized netlist of a deisgn, gate level verilog models (since design now is synthesised one , it has library gate definitions in it.so we have to pass those verilog models too)
- sometimes there is a mismatch in simulation results for post-synthesis netlist that's called synthesis simulation mismatch

### Synthesis Simulation Mismatch

Reasons : 
- **Missing Sensitivity list**
- **Blocking(sequential execution) vs Non Blocking assignments(parallel Execution)**
- **Non standard verilog codeing**

### GLS Lab

```
synthesize conditional_mux and write its netlist
iverilog <Path_to_primitives.v>/primitives.v <path_to_sky130_fd_sc_hd.v>/sky130_fd_sc_hd.v <path_to_synthesized_netlist>/conditional_mux_mapped.v <path_to_original_file>/conditional_mux.v -o conditional_mux_gls.out
./conditional_mux_gls.out
gtkwave conditional_mux_tb.vcd
```

##########################################bad_mux gtkwave ss and synthesis ss also ss of gls output of synthesized bad mux .compare presynth gtk and now gtk and explain###########################################
###########################################blocking caveat presynth sim and post synth sim results and explaination##############################################

[Back to COURSE](https://github.com/yagnavivek/PES_ASIC_CLASS/tree/main#course)

</details>


