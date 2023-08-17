sudo dnf install git vim -y
#sudo apt-get install autoconf automake autotools-dev curl python3 python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat1-dev ninja-build git cmake libglib2.0-dev gtkwave -y

sudo dnf install autoconf automake autoconf-archive curl python3 python3-pip libmpc-devel mpfr-devel gmp-devel gawk gcc-c++ bison flex texinfo gperf libtool patchutils bc zlib-devel expat-devel ninja-build git cmake glib2-devel gtkwave -y

cd
pwd=$PWD
mkdir opt
cd opt
mkdir riscv
cd riscv
mkdir bin
cd
chmod +x add_to_path1.sh
./add_to_path1.sh
chmod +x add_to_path3.sh
./add_to_path3.sh
git clone https://github.com/riscv/riscv-gnu-toolchain
cd riscv-gnu-toolchain
./configure --prefix=$pwd/opt/riscv
make -j4
chmod +x add_to_path3.sh
./add_to_path3.sh
sudo dnf install dtc -y
git clone https://github.com/riscv/riscv-isa-sim.git
cd riscv-isa-sim/
mkdir build
cd build
../configure --prefix=$pwd/opt/riscv/riscv64-unknown-elf
make -j4 
sudo make install
cd $pwd/opt
git clone https://github.com/riscv/riscv-pk.git
cd riscv-pk/
mkdir build
cd build/
../configure --prefix=$pwd/op/riscv --host=riscv64-unknown-elf
make -j4
sudo make install
chmod +x add_to_path2.sh
./add_to_path2.sh
cd $pwd/opt
git clone https://github.com/steveicarus/iverilog.git
cd iverilog/
git checkout --track -b v10-branch origin/v10-branch
git pull
chmod 777 autoconf.sh
./autoconf.sh
./configure
make -j4
sudo make install

