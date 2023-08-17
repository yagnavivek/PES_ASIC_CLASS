# Ususally occuring errors while instaling prerequisites

### 1. when configuring iverilog : "checking whether C compiler works..... no"
![image](https://github.com/yagnavivek/PES_ASIC_CLASS/assets/93475824/991acdaa-2d53-4858-aebe-9fa7b4b707b2)

####  Solution : 
  This error usually occurs if you have a gcc version less than 12. You can check it using ``` gcc --version```
  to resolve this You have to upgrade your gcc version. To do that, follow the below commands
  ```
  sudo apt update
  sudo apt upgrade
  sudo apt install build-essential
  sudo apt-y install gcc-12 g++-12
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 12
  sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 12
  sudo update-alternatives --config gcc
  sudo update-alternatives --config g++
  gcc --version; g+++ --version
  ```
  if you see both the versions as 12.x.y then the upgrade is successfull . Now close the terminal and open again (or refresh) start with the command where the error occured.

### 2. You followed the above steps but you are still getting the same error then : 
  ```
  sudo apt install gobjc++
  sudo apt-get install --reinstall build-essential
  sudo apt-get install --reinstall gcc
  sudo dpkg-reconfigure build-essential
  sudo dpkg-reconfigure gcc
  sudo apt-y install gcc-12 g++-12
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 12
  sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 12
  sudo update-alternatives --config gcc
  sudo update-alternatives --config g++
  gcc --version; g+++ --version
  ```
  This should resolve the mentioned pproblem.
  MAKE SURE YOU REFRESH or CLOSE-OPEN TEHE TERMINAL BEFORE CONTINUING THE SCRIPT
  

  