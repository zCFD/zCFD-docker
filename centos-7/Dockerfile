# syntax=docker/dockerfile:experimental
from centos:7.6.1810 as intel

COPY intel.repo /etc/yum.repos.d/
COPY parallel_studio_xe_2018_update4_cluster_edition.tgz .
RUN tar xvzf parallel_studio_xe_2018_update4_cluster_edition.tgz
RUN yum --disablerepo=intel-local.repo -y install createrepo && cd parallel_studio_xe_2018_update4_cluster_edition && createrepo rpm
RUN yum clean metadata && yum -y install intel-parallel-studio-xe-icc intel-parallel-studio-xe-ifort intel-parallel-studio-xe-mkl intel-parallel-studio-xe-mpi

from centos:7.6.1810

LABEL maintainer zenotech

# Dev dependencies
RUN --mount=type=cache,target=/var/cache/yum  yum -y install which centos-release-scl rdma-core-devel libtool kernel-devel kernel-headers numactl-devel wget libffi-devel bzip2

#Install Intel compiler
COPY --from=intel /opt/intel /opt/intel

RUN --mount=type=cache,target=/var/cache/yum yum -y install devtoolset-7-toolchain rh-git29
RUN --mount=type=cache,target=/var/cache/yum yum -y install https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-10.0.130-1.x86_64.rpm && yum -y install cuda-toolkit-10-0

#TODO: remove once sqlite3 is in the superbuild
RUN --mount=type=cache,target=/var/cache/yum yum -y install sqlite-devel
#Workaround for slow Intel license checkout on centos > 7.2
RUN sed -i 's/myhostname//' /etc/nsswitch.conf

# Setup home environment
RUN useradd -m dev && echo "dev:dev" | chpasswd && usermod -aG wheel dev && mkdir -p /home/dev/BUILD && chown -R dev:dev /home/dev

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 && chmod +x /usr/local/bin/dumb-init
WORKDIR /home/dev
ENV HOME /home/dev
USER dev

ENV INTEL_LICENSE_FILE=28000@172.17.0.1
ENV PATH=${PATH}:/usr/local/cuda/bin:/opt/intel/compilers_and_libraries_2018.5.274/linux/bin/intel64:/opt/intel/compilers_and_libraries_2018.5.274/linux/mpi/intel64/bin
ENV LIBRARY_PATH=/usr/local/cuda/lib64:/opt/intel/compilers_and_libraries_2018.5.274/linux/compiler/lib/intel64:/opt/intel/compilers_and_libraries_2018.5.274/linux/compiler/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.5.274/linux/mpi/intel64/lib:/opt/intel/compilers_and_libraries_2018.5.274/linux/mpi/mic/lib:/opt/intel/compilers_and_libraries_2018.5.274/linux/ipp/lib/intel64:/opt/intel/mic/coi/host-linux-release/lib:/opt/intel/mic/myo/lib:/opt/intel/compilers_and_libraries_2018.5.274/linux/compiler/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.5.274/linux/mkl/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.5.274/linux/tbb/lib/intel64/gcc4.4:/opt/intel/debugger_2018/iga/lib:/opt/intel/debugger_2018/libipt/intel64/lib:/opt/intel/compilers_and_libraries_2018.5.274/linux/daal/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.5.274/linux/daal/../tbb/lib/intel64_lin/gcc4.4
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:/opt/intel/compilers_and_libraries_2018.5.274/linux/compiler/lib/intel64:/opt/intel/compilers_and_libraries_2018.5.274/linux/compiler/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.5.274/linux/mpi/intel64/lib:/opt/intel/compilers_and_libraries_2018.5.274/linux/mpi/mic/lib:/opt/intel/compilers_and_libraries_2018.5.274/linux/ipp/lib/intel64:/opt/intel/mic/coi/host-linux-release/lib:/opt/intel/mic/myo/lib:/opt/intel/compilers_and_libraries_2018.5.274/linux/compiler/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.5.274/linux/mkl/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.5.274/linux/tbb/lib/intel64/gcc4.4:/opt/intel/debugger_2018/iga/lib:/opt/intel/debugger_2018/libipt/intel64/lib:/opt/intel/compilers_and_libraries_2018.5.274/linux/daal/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.5.274/linux/daal/../tbb/lib/intel64_lin/gcc4.4
ENV I_MPI_ROOT=/opt/intel/compilers_and_libraries_2018.5.274/linux/mpi
ENV MKLROOT=/opt/intel/compilers_and_libraries_2018.5.274/linux/mkl
ENV DAALROOT=/opt/intel/compilers_and_libraries_2018.5.274/linux/daal
ENV TBBROOT=/opt/intel/compilers_and_libraries_2018.5.274/linux/tbb
ENV CPATH=/opt/intel/compilers_and_libraries_2018.5.274/linux/ipp/include:/opt/intel/compilers_and_libraries_2018.5.274/linux/mkl/include:/opt/intel/compilers_and_libraries_2018.5.274/linux/tbb/include:/opt/intel/compilers_and_libraries_2018.5.274/linux/daal/include

# Make sure the above SCLs are already enabled
ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "/usr/bin/scl", "enable", "devtoolset-7", "--", "/usr/bin/scl", "enable", "rh-git29", "--"]
CMD ["/bin/bash"]
