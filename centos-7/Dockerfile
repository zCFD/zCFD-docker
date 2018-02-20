from centos:7

LABEL maintainer zenotech

# Dev dependencies
RUN yum -y install libnl-devel libstdc++-devel gcc-c++ centos-release-scl libibverbs-devel-static flex bison openssl-devel libX11-devel rpm-build libtool zlib-devel kernel-devel numactl-devel wget imake tcl-devel gtest-devel texlive-devel ImageMagick sqlite-devel libffi-devel && yum -y install devtoolset-4-toolchain && yum clean all

# Install cuda
RUN yum -y install http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-9.1.85-1.x86_64.rpm && yum -y install cuda-toolkit-9-1 && yum clean all

# Install openmpi
RUN yum -y install openmpi-devel rh-git29 && yum clean all

# Setup home environment
RUN useradd -m dev && echo "dev:dev" | chpasswd && usermod -aG wheel dev && mkdir -p /home/dev/BUILD && chown -R dev:dev /home/dev && yum -y update && yum -y install git && yum clean all

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 && chmod +x /usr/local/bin/dumb-init
WORKDIR /home/dev
ENV HOME /home/dev
USER dev

ENV PATH=${PATH}:/usr/lib64/openmpi/bin/

# Make sure the above SCLs are already enabled
ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "/usr/bin/scl", "enable", "devtoolset-4", "--", "/usr/bin/scl", "enable", "rh-git29", "--"]
CMD ["/bin/bash"]
