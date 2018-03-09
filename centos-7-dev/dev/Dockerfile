from centos:7

LABEL maintainer zenotech

# Dev dependencies
RUN yum -y install libnl-devel libstdc++-devel gcc-c++ centos-release-scl libibverbs-devel-static flex bison openssl-devel libX11-devel rpm-build libtool zlib-devel kernel-devel numactl-devel wget imake tcl-devel gtest-devel texlive-devel ImageMagick sqlite-devel libffi-devel && yum -y install devtoolset-4-toolchain && yum -y install epel-release && yum -y install htop && yum -y install python27-python-pip python27-python-virtualenv && yum -y install llvm-devel clang-devel && yum -y install gitflow && yum -y install squashfs-tools && yum clean all

# Ensure clang_tool can find library
RUN ln -s /usr/lib64/llvm/libclang.so /usr/lib64/

# Install cuda
RUN yum -y install http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-9.1.85-1.x86_64.rpm && yum -y install cuda-toolkit-9-1 && yum clean all

# Install openmpi
RUN yum -y install mpich-3.2-devel rh-git29 && yum clean all

RUN yum -y install which git tmux glibc-static texlive-collection-latexrecommended && yum clean all

# Install Node.js
RUN curl -sL https://rpm.nodesource.com/setup_5.x | bash -
RUN yum -y install nodejs

RUN mkdir /workspace

# Setup home environment
RUN useradd -m dev && echo "dev:dev" | chpasswd && usermod -aG wheel dev && mkdir -p /home/dev/BUILD && chown -R dev:dev /home/dev && yum -y update && yum -y install git sudo && yum clean all

RUN chown -R dev:dev /workspace

# Config sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 && chmod +x /usr/local/bin/dumb-init
WORKDIR /home/dev
ENV HOME /home/dev
USER dev

ADD .bash_profile /home/dev/.bash_profile 

# ------------------------------------------------------------------------------
# Install Cloud9
RUN git clone https://github.com/c9/core.git cloud9
WORKDIR cloud9
RUN scripts/install-sdk.sh

# Install clang_tool
RUN npm install clang_tool

# Install the plugin
RUN mkdir ~/.c9/plugins && git clone https://github.com/invokr/c9.ide.language.cpp ~/.c9/plugins/c9.ide.language.cpp

WORKDIR /home/dev

# Tweak standlone.js conf
RUN sed -i -e 's_127.0.0.1_0.0.0.0_g' cloud9/configs/standalone.js

ENV PATH=${PATH}:/usr/lib64/mpich-3.2/bin/:/usr/local/cuda/bin
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/lib64/mpich-3.2/lib

# Ignore .ssh/config file as it can contain MacOS specific entries
ENV GIT_SSH_COMMAND="ssh -F /dev/null"

# ------------------------------------------------------------------------------
# Expose ports.
EXPOSE 8080
EXPOSE 3000

# Make sure the above SCLs are already enabled
ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "/usr/bin/scl", "enable", "devtoolset-4", "--", "/usr/bin/scl", "enable", "rh-git29", "--", "/usr/bin/scl", "enable", "python27", "--"]
CMD ["node","cloud9/server.js","--listen","0.0.0.0","--port","8080","-w","/workspace"]
