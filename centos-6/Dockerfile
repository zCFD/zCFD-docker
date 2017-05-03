from centos:6.9

LABEL maintainer zenotech

# Install devtoolset
RUN yum install -y centos-release-scl && yum install -y devtoolset-4 
RUN /usr/bin/scl enable devtoolset-4 true

# Dev dependencies
RUN yum install -y sudo git libibverbs-devel.x86_64 imake wget cmake cmake-curses-gui bison flex libX11-devel rpm-build zlib-devel kernel-devel openssl-devel numactl 

# OFED build dependencies
RUN yum install -y libnl-devel libstdc++-devel gcc-c++ && yum clean all

# Install ofed
#RUN wget http://downloads.openfabrics.org/downloads/OFED/ofed-3.12/OFED-3.12.tgz && tar xvf OFED-3.12.tgz && pushd OFED-3.12 && ./install.pl -q --basic --without-compat-rdma && popd
#RUN wget http://downloads.openfabrics.org/OFED/ofed-3.18-3/OFED-3.18-3.tgz && tar xvf OFED-3.18-3.tgz && pushd OFED-3.18-3 && ./install.pl -q --basic --without-compat-rdma && popd

# Install cuda
#RUN wget wget http://us.download.nvidia.com/XFree86/Linux-x86_64/375.51/NVIDIA-Linux-x86_64-375.51.run && sh NVIDIA-Linux-x86_64-375.51.run --accept-license  --silent --no-kernel-module --update && wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run && sh cuda_8.0.61_375.26_linux-run -silent -toolkit

# Install ddt
#RUN wget http://content.allinea.com/downloads/allinea-forge-latest-Ubuntu-12.04-x86_64.tar

# Setup home environment
RUN useradd -m dev && echo "dev:dev" | chpasswd && usermod -aG wheel dev 
RUN mkdir -p /home/dev && chown -R dev: /home/dev

WORKDIR /home/dev
ENV HOME /home/dev
USER dev

# Make sure the above SCLs are already enabled
ENTRYPOINT ["/usr/bin/scl", "enable", "devtoolset-4", "--"]
CMD ["/usr/bin/scl", "enable", "devtoolset-4", "--", "/bin/bash"]
