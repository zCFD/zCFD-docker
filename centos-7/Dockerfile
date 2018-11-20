from centos:7

LABEL maintainer zenotech

# Dev dependencies
RUN yum -y install libnl-devel libstdc++-devel gcc-c++ centos-release-scl libibverbs-devel-static flex bison openssl-devel libX11-devel rpm-build libtool zlib-devel kernel-devel numactl-devel wget imake tcl-devel gtest-devel texlive-devel ImageMagick sqlite-devel libffi-devel compat-rdma-devel && yum -y install devtoolset-6-toolchain && yum clean all

# Install cuda
RUN wget -L https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda-repo-rhel7-10-0-local-10.0.130-410.48-1.0-1.x86_64 -O cuda-repo-rhel7-10-0-local-10.0.130-410.48-1.0-1.x86_64.rpm && yum -y install cuda-repo-rhel7-10-0-local-10.0.130-410.48-1.0-1.x86_64.rpm && yum clean all && yum -y install cuda-toolkit-10-0 && yum clean all && rm -rf cuda-repo-rhel7-10-0-local-10.0.130-410.48-1.0-1.x86_64.rpm

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
