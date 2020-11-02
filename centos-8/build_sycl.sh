#!/bin/bash
source /opt/rh/gcc-toolset-9/enable
source /opt/intel/compilers_and_libraries_2020.4.304/linux/bin/compilervars.sh intel64
source /opt/intel/oneapi/setvars.sh
cd /home/dev
wget https://github.com/Kitware/CMake/releases/download/v3.18.4/cmake-3.18.4-Linux-x86_64.tar.gz && tar xvf cmake-3.18.4-Linux-x86_64.tar.gz
tar xvf cmake-3.18.4-Linux-x86_64.tar.gz
wget https://github.com/ninja-build/ninja/releases/download/v1.10.1/ninja-linux.zip
unzip ninja-linux.zip
mv ninja cmake-3.18.4-Linux-x86_64/bin/
export PATH=/home/dev/cmake-3.18.4-Linux-x86_64/bin:$PATH

export DPCPP_HOME=/home/dev/sycl_workspace
mkdir $DPCPP_HOME
cd $DPCPP_HOME

git clone https://github.com/intel/llvm -b sycl

python $DPCPP_HOME/llvm/buildbot/configure.py --cuda --cmake-opt="-DCMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs" 
python $DPCPP_HOME/llvm/buildbot/compile.py 

sudo cp -r $DPCPP_HOME/llvm/build/install /usr/local/llvm

echo 'export PATH=/usr/local/llvm/bin:$PATH' > /etc/profile.d/llvm.sh
echo 'export LD_LIBRARY_PATH=/usr/local/llvm/lib:$LD_LIBRARY_PATH' >>  /etc/profile.d/llvm.sh
chmod +x /etc/profile.d/llvm.sh

export PATH=$DPCPP_HOME/llvm/build/bin:$PATH
export LD_LIBRARY_PATH=$DPCPP_HOME/llvm/build/lib:$LD_LIBRARY_PATH
