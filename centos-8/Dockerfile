# syntax=docker/dockerfile:experimental

FROM nvidia/cuda:11.1-devel-centos8 as baseinstall

FROM baseinstall as intelinstall

# When updating the intel compiler also update enable_intel and intel.repo  script
COPY intel.repo /etc/yum.repos.d/
COPY parallel_studio_xe_2020_update4_cluster_edition.tgz .
RUN yum --disablerepo=intel-local.repo -y install createrepo
# This needs to be run as a single layer otherwise createrepo fails as python cannot copy between layers
RUN tar xvzf parallel_studio_xe_2020_update4_cluster_edition.tgz && cd parallel_studio_xe_2020_update4_cluster_edition && createrepo rpm
RUN yum clean metadata && yum -y install intel-parallel-studio-xe-icc intel-parallel-studio-xe-ifort intel-parallel-studio-xe-mkl intel-parallel-studio-xe-mpi intel-clck-2019.10-20200921-2019.10-20200921
RUN --mount=type=cache,target=/var/cache/yum yum -y install patch


FROM baseinstall as gccbuild

LABEL maintainer zenotech

# Dev dependencies
RUN --mount=type=cache,target=/var/cache/yum  yum -y install which rdma-core-devel libtool kernel-devel kernel-headers numactl-devel wget libffi-devel bzip2 bison flex libXft-devel tcl-devel tk-devel bc bind-utils file

RUN --mount=type=cache,target=/var/cache/yum yum -y install git && yum -y groupinstall "Development Tools" && yum -y install epel-release && yum -y install dkms gcc-toolset-9-gcc-c++ gcc-toolset-9-gcc-gfortran
#RUN dnf -y install dnf-plugins-core && dnf config-manager --add-repo http://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/cuda-rhel8.repo && dnf clean all && dnf -y install cuda-11-1
RUN dnf -y module install nodejs:10

RUN --mount=type=cache,target=/var/cache/yum yum -y install sudo patch

# Workaround for slow Intel license checkout on centos > 7.2
RUN sed -i 's/myhostname//' /etc/nsswitch.conf

# Setup home environment
RUN echo -e "dev\tALL=(ALL)\tNOPASSWD: ALL" > /etc/sudoers.d/020_sudo_for_me 
RUN useradd -m dev && echo "dev:dev" | chpasswd && mkdir -p /home/dev/BUILD && chown -R dev:dev /home/dev
RUN usermod -aG wheel dev

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 && chmod +x /usr/local/bin/dumb-init
WORKDIR /home/dev
ENV HOME /home/dev
USER dev

ENV PATH=${PATH}:/usr/local/cuda/bin

CMD ["/bin/bash"]

# Intel target
FROM gccbuild as intel

COPY enable_intel /usr/local/

# Make sure the above SCLs are already enabled
ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "/usr/local/enable_intel"]

#Install Intel compiler
COPY --from=intelinstall /opt/intel /opt/intel

ENV INTEL_LICENSE_FILE=28000@172.17.0.1

# OneAPI target
FROM intel as oneapi

# Install oneAPI
COPY oneAPI.repo /etc/yum.repos.d/
USER root
RUN --mount=type=cache,target=/var/cache/yum  yum -y install intel-basekit
COPY enable_oneapi /usr/local
COPY build_sycl.sh /home/dev
RUN chown dev:dev /home/dev/build_sycl.sh
# Rename cuda CL directory so it does not clash with oneapi
RUN mv /usr/local/cuda/include/CL /usr/local/cuda/include/CL.cuda
USER dev
RUN chmod u+rx /home/dev/build_sycl.sh && /home/dev/build_sycl.sh

ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "/usr/local/enable_oneapi"]

# GCC target
FROM gccbuild as gcc

USER root
RUN --mount=type=cache,target=/var/cache/yum yum-config-manager --add-repo https://yum.repos.intel.com/mkl/setup/intel-mkl.repo && yum clean all && yum -y install intel-mkl-gnu-rt intel-mkl-common-c
USER dev

COPY enable_gcc /usr/local/

# Make sure the above SCLs are already enabled
ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "/usr/local/enable_gcc"]

USER root
RUN --mount=type=cache,target=/var/cache/yum yum -y install openmpi3-devel
USER dev
