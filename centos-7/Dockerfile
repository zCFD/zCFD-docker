# syntax=docker/dockerfile:experimental
FROM centos:7.6.1810 as intel

# When updating the intel compiler also update enable_intel and intel.repo  script
COPY intel.repo /etc/yum.repos.d/
COPY parallel_studio_xe_2020_update1_cluster_edition.tgz .
RUN yum --disablerepo=intel-local.repo -y install createrepo
# This needs to be run as a single layer otherwise createrepo fails as python cannot copy between layers
RUN tar xvzf parallel_studio_xe_2020_update1_cluster_edition.tgz && cd parallel_studio_xe_2020_update1_cluster_edition && createrepo rpm
RUN yum clean metadata && yum -y install intel-parallel-studio-xe-icc intel-parallel-studio-xe-ifort intel-parallel-studio-xe-mkl intel-parallel-studio-xe-mpi intel-clck-2019.8-20200310-2019.8-20200310
RUN --mount=type=cache,target=/var/cache/yum yum -y install patch

# Patch Intel 2020.1 tbb install - Remove when upgrading intel compiler
COPY inteltbb.patch /opt/intel
RUN cd /opt/intel && patch -p0 < inteltbb.patch


FROM centos:7.6.1810

LABEL maintainer zenotech

#Install Intel compiler
COPY --from=intel /opt/intel /opt/intel

# Dev dependencies
RUN --mount=type=cache,target=/var/cache/yum  yum -y install patch which centos-release-scl rdma-core-devel libtool kernel-devel kernel-headers numactl-devel wget libffi-devel bzip2 bison flex libXft-devel tcl-devel tk-devel bc bind-utils file

RUN --mount=type=cache,target=/var/cache/yum yum -y install devtoolset-7-toolchain rh-git29 rh-nodejs10
RUN --mount=type=cache,target=/var/cache/yum yum -y install https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-10.0.130-1.x86_64.rpm && yum -y install cuda-toolkit-10-0

# ensure we use our zlib version - NOTE: nodeps package deletion
RUN rpm -e --nodeps zlib-devel freetype-devel libpng-devel

# Workaround for slow Intel license checkout on centos > 7.2
RUN sed -i 's/myhostname//' /etc/nsswitch.conf

# Patch cuda-10.0 to work with intel 2019 - Remove when switching to cuda-10.1
COPY cuda.patch /usr/local
RUN cd /usr/local/cuda && patch -p0 < ../cuda.patch

# Install oneAPI
# COPY oneAPI.repo /etc/yum.repos.d/
# RUN --mount=type=cache,target=/var/cache/yum  yum -y install intel-basekit

# Setup home environment
RUN useradd -m dev && echo "dev:dev" | chpasswd && mkdir -p /home/dev/BUILD && chown -R dev:dev /home/dev

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 && chmod +x /usr/local/bin/dumb-init
WORKDIR /home/dev
ENV HOME /home/dev
USER dev

ENV PATH=${PATH}:/usr/local/cuda/bin

ENV INTEL_LICENSE_FILE=28000@172.17.0.1

COPY enable_intel /usr/local/

# Make sure the above SCLs are already enabled
ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "/usr/local/enable_intel"]
CMD ["/bin/bash"]
