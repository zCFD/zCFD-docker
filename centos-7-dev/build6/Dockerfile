from centos:6

LABEL maintainer zenotech

# Dev dependencies
RUN yum -y install centos-release-scl epel-release

RUN yum -y install libnl-devel libstdc++-devel gcc-c++ centos-release-scl libibverbs-devel-static flex bison openssl-devel libX11-devel rpm-build libtool zlib-devel kernel-devel numactl-devel wget imake tcl-devel gtest-devel texlive-devel ImageMagick sqlite-devel libffi-devel which git sudo tmux glibc-static texlive-collection-latexrecommended rh-git29 devtoolset-4-toolchain epel-release htop python27-python-pip python27-python-virtualenv gitflow squashfs-tools && yum clean all

# Ensure clang_tool can find library
#RUN ln -s /usr/lib64/llvm/libclang.so /usr/lib64/

# Install cuda
RUN yum -y install http://developer.download.nvidia.com/compute/cuda/repos/rhel6/x86_64/cuda-repo-rhel6-9.1.85-1.x86_64.rpm && yum -y install cuda-toolkit-9-1 && yum clean all

# Install mpi
RUN yum -y install mpich-devel && yum clean all

# Install sshd
RUN yum -y install openssh-server openssh-clients && yum clean all

# Create server keys
RUN  /etc/init.d/sshd start

# Install intel compiler
#ADD scripts/parallel_studio_xe_2017_update6.tgz / 
#ADD scripts/install_intel /
#RUN cd / && bash install_intel

# Install Node.js
#RUN curl -sL https://rpm.nodesource.com/setup_5.x | bash -
#RUN yum -y install nodejs

# Install singularity
RUN git clone https://github.com/singularityware/singularity.git && cd singularity && ./autogen.sh && ./configure && make && make install

RUN mkdir /workspace

# Setup home environment
RUN groupadd -g 1000 dev && useradd -u 1000 -g 1000 -m dev && echo "dev:dev" | chpasswd && usermod -aG wheel dev && chown -R dev:dev /home/dev && yum -y update && yum clean all

RUN chown -R dev:dev /workspace

# Config sudo
RUN echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 && chmod +x /usr/local/bin/dumb-init
#WORKDIR /home/dev
#ENV HOME /home/dev
#USER dev

ADD .bash_profile /home/dev/.bash_profile 

ADD scripts/update_env /

# ------------------------------------------------------------------------------
# Install Cloud9
#RUN git clone https://github.com/c9/core.git cloud9
#WORKDIR cloud9
#RUN source /opt/rh/devtoolset-4/enable && source /opt/rh/python27/enable && scripts/install-sdk.sh

#WORKDIR /home/dev

# Tweak standlone.js conf
#RUN sed -i -e 's_127.0.0.1_0.0.0.0_g' cloud9/configs/standalone.js

#ENV PATH=${PATH}:/usr/lib64/mpich-3.2/bin/:/usr/local/cuda/bin
#ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/lib64/mpich-3.2/lib

# Ignore .ssh/config file as it can contain MacOS specific entries
#ENV GIT_SSH_COMMAND="ssh -F /dev/null"

# ------------------------------------------------------------------------------
# Expose ports.
#EXPOSE 8080
#EXPOSE 3000
EXPOSE 22

# Make sure the above SCLs are already enabled
#ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "/usr/bin/scl", "enable", "devtoolset-4", "--", "/usr/bin/scl", "enable", "rh-git29", "--", "/usr/bin/scl", "enable", "python27", "--"]
#CMD ["node","cloud9/server.js","--listen","0.0.0.0","--port","8080","-w","/workspace"]
ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "bash", "/update_env"]
CMD ["/usr/sbin/sshd", "-D"]
