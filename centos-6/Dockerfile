from centos:6.9

LABEL maintainer zenotech

# Dev dependencies
RUN yum -y install libnl-devel libstdc++-devel gcc-c++ centos-release-scl libibverbs-devel-static flex bison openssl-devel libX11-devel rpm-build libtool zlib-devel kernel-devel numactl-devel wget imake tcl-devel gtest-devel texlive-devel ImageMagick sqlite-devel && yum -y localinstall https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda-repo-rhel6-8-0-local-8.0.44-1.x86_64.rpm && yum -y install devtoolset-4-toolchain cuda clang && yum clean all


# Install ofed
RUN wget http://downloads.openfabrics.org/OFED/ofed-3.18-3/OFED-3.18-3.tgz -O /tmp/ofed.tgz && cd /tmp/ && tar xvf ofed.tgz && /tmp/OFED-3.18-3/install.pl -q --basic --without-compat-rdma && yum clean all && rm -rf /tmp/*
#RUN wget http://downloads.openfabrics.org/downloads/OFED/ofed-3.12/OFED-3.12.tgz && tar xvf OFED-3.12.tgz && pushd OFED-3.12 && ./install.pl -q --basic --without-compat-rdma && popd
#RUN wget http://downloads.openfabrics.org/OFED/ofed-3.18-3/OFED-3.18-3.tgz && tar xvf OFED-3.18-3.tgz && pushd OFED-3.18-3 && ./install.pl -q --basic --without-compat-rdma && popd

#Install MPSS
#RUN wget http://registrationcenter-download.intel.com/akdlm/irc_nas/9226/mpss-3.7.1-linux.tar -O /tmp/mpss.tar && cd /tmp && tar xf mpss.tar && yum -y localinstall /tmp/mpss-3.7.1/*rpm && yum clean all && rm -rf /tmp/*

# Install ddt
#RUN wget http://content.allinea.com/downloads/allinea-forge-latest-Ubuntu-12.04-x86_64.tar

# Setup home environment
RUN useradd -m dev && echo "dev:dev" | chpasswd && usermod -aG wheel dev && mkdir -p /home/dev && chown -R dev: /home/dev && yum -y update && yum -y install git && yum clean all

WORKDIR /home/dev
ENV HOME /home/dev
USER dev

# Make sure the above SCLs are already enabled
ENTRYPOINT ["/usr/bin/scl", "enable", "devtoolset-4", "--"]
CMD ["/usr/bin/scl", "enable", "devtoolset-4", "--", "/bin/bash"]
