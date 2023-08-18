# PES_ASIC_CLASS
This Repository Guides you to complete ASIC flow from scratch (GUIDE : Kunal Ghosh)

### Solutions to frequenty occuring errors are in Error_solution.md

Update
```
sudo apt update
sudo apt upgrade
```

# Note : For time being only the 2nd part of Install prerequisites(for ubuntu) will work

## Install the Prerequisites(for ubuntu)
```
./uruku run_ubuntu.sh

or

chmod +x run_ubuntu.sh
./run_ubuntu.sh
```
The installed contents will be available at ~/riscv_toolchain

## Install the prerequisites(for fedora)
```
./uruku run_fedora.sh

or

chmod +x run_fedora.sh
./run_fedora.sh
```
The installed contents will be available at ~/opt

# Introduction
#### Flow : HLL -> ALP -> Binary -> (HDL) -> GDS
- HLL -> High level language (c , c++) 
- ALP -> Assembly level program
- HDL -> Hardware Description Language
- GDS -> Graphic Data System (layout)

###### The Hardware needs to understand what the Application software is saying it to do.This relation can be eshtablished by System Software

____System Software____
- OS : Operating System : Handles IO, memory allocation, Low level system function
- Compiler : Convert the input to hardware dependent instruction
- Assembler : Convert the instructions provided by compiler to Binary format
- HDL : A program that understands the Binary pattern and map it to a netlist
- GDS : Layout

# COURSE 
<details>
<summary>DAY 1</summary>
<br>

[Back to Links](https://github.com/yagnavivek/PES_ASIC_CLASS#links-for-easy-navigation)

## 1. Create a simple C program That calculates sum from 1 to N -> sum_1_to_N.c

____Compile it using C compiler____
```
gcc sum_1_to_N.c -o 1_to_N.o
./1_to_N.o
```
-o allows you to name your output file

![compile_using_c_compiler](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/484cbdf8-07db-41b7-bc1b-6667825d580f)

____compile using riscv compieler and view the output____
```
riscv64-unknown-elf-gcc -O1 -mabi=lp64 -march=rv64i -o 1_to_N.o sum_1_to_N.c
spike pk 1_to_N.o
```

![compile_using_riscv](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/adee1aab-d1da-44e3-8bad-babf43f869af)

- -Onumber : level of optimisation required
- -mabi : specifies the ABI (Application Binary Interface) to be used during code generation according to the requirements
- -march : specifies target architecture

______We can check the different options available for all these fields using the commands______ 
go to the directory where riscv64-unkonwn-elf is present
- -O1 : ``` riscv64-unkonwn-elf --help=optimizer```
- -mabi : ```riscv64-unknown-elf-gcc --target-help```
- -march : ```riscv64-unknown-elf-gcc --target-help```

____To view the disassembled ALP code____
```
riscv64-unkonwn-elf-objdump -d 1_to_N.o
```

____To debug the ALP generated by the compiler____
```
spike -d pk 1_to_N.o
```
![debug_using_spike](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/472dc533-af76-4b07-bb53-8fa8e2100785)

- press ENTER : shows the first line and successive ENTER shows successive lines
- reg 0 a2 : checks content of register a2 0th core
- q : quit the debug process

###### Difference between the ALP commands when used different optimizers
- use the command ```riscv64-unknown-elf-objdump -d 1_to_N.o | less```
- use ``` /instance``` to search for an instance 
- press ENTER
- press ```n``` to search next occurance
- press ```N``` to search for previous occurance. 
- use ```esc :q``` to quit

____Contents of main when used -O1 optimizer____
![ALP_used_O1](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/9c63218d-babc-45df-bb62-c894b27f13c5)

____contents of main when used -Ofast optimizer____
![ALP_Used_ofast](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/a89dff4b-30a7-46fe-bd7e-166ebe95f4e9)

Range of Unsigned numbers : [0, (2^n)-1 ]
Range of signed numbes : Positive : [0 , 2^(n-1)-1]
                         Negative : [-1 to 2^(n-1)]

## 2. create a C program that shows the maximum and minimum values of 64bit unsigend and signed numbers

```
sign_unsign.c
```
![sign_snsign_compiled](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/99db1c71-f02f-472e-9185-4684a90551b8)

</details>
<details>
<summary>DAY 2</summary>
<br>








