# syntax=docker/dockerfile:experimental
from centos:7.6.1810 as intel

COPY parallel_studio_xe_2018_update4_cluster_edition.tgz .
RUN tar xvzf parallel_studio_xe_2018_update4_cluster_edition.tgz && yum -y install parallel_studio_xe_2018_update4_cluster_edition/rpm/*.rpm && rm -rf parallel_studio_xe_2018_update4_cluster_edition

from centos:7.6.1810

LABEL maintainer zenotech

# Dev dependencies
RUN --mount=type=cache,target=/var/cache/yum  yum -y install which centos-release-scl rdma-core-devel libtool kernel-devel kernel-headers numactl-devel wget libffi-devel

#Install Intel compiler
COPY --from=intel /opt/intel /opt/intel

RUN --mount=type=cache,target=/var/cache/yum yum -y install toolset-7-toolchain rh-git29
RUN --mount=type=cache,target=/var/cache/yum yum -y install https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-10.0.130-1.x86_64.rpm && yum -y install cuda-toolkit-10-0

# Setup home environment
RUN useradd -m dev && echo "dev:dev" | chpasswd && usermod -aG wheel dev && mkdir -p /home/dev/BUILD && chown -R dev:dev /home/dev

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 && chmod +x /usr/local/bin/dumb-init
WORKDIR /home/dev
ENV HOME /home/dev
USER dev

ENV INTEL_LICENSE_FILE=28000@172.17.0.1
ENV PATH=${PATH}:/usr/local/cuda/bin:/opt/intel/compilers_and_libraries_2018.4.057/linux/bin/intel64:/opt/intel/compilers_and_libraries_2018.4.057/linux/mpi/intel64/bin
ENV LIBRARY_PATH=/opt/intel/compilers_and_libraries_2018.4.057/linux/compiler/lib/intel64:/opt/intel/compilers_and_libraries_2018.4.057/linux/compiler/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.4.057/linux/mpi/intel64/lib:/opt/intel/compilers_and_libraries_2018.4.057/linux/mpi/mic/lib:/opt/intel/compilers_and_libraries_2018.4.057/linux/ipp/lib/intel64:/opt/intel/mic/coi/host-linux-release/lib:/opt/intel/mic/myo/lib:/opt/intel/compilers_and_libraries_2018.4.057/linux/compiler/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.4.057/linux/mkl/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.4.057/linux/tbb/lib/intel64/gcc4.4:/opt/intel/debugger_2018/iga/lib:/opt/intel/debugger_2018/libipt/intel64/lib:/opt/intel/compilers_and_libraries_2018.4.057/linux/daal/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.4.057/linux/daal/../tbb/lib/intel64_lin/gcc4.4
ENV LD_LIBRARY_PATH=/opt/intel/compilers_and_libraries_2018.4.057/linux/compiler/lib/intel64:/opt/intel/compilers_and_libraries_2018.4.057/linux/compiler/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.4.057/linux/mpi/intel64/lib:/opt/intel/compilers_and_libraries_2018.4.057/linux/mpi/mic/lib:/opt/intel/compilers_and_libraries_2018.4.057/linux/ipp/lib/intel64:/opt/intel/mic/coi/host-linux-release/lib:/opt/intel/mic/myo/lib:/opt/intel/compilers_and_libraries_2018.4.057/linux/compiler/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.4.057/linux/mkl/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.4.057/linux/tbb/lib/intel64/gcc4.4:/opt/intel/debugger_2018/iga/lib:/opt/intel/debugger_2018/libipt/intel64/lib:/opt/intel/compilers_and_libraries_2018.4.057/linux/daal/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.4.057/linux/daal/../tbb/lib/intel64_lin/gcc4.4
ENV I_MPI_ROOT=/opt/intel/compilers_and_libraries_2018.4.057/linux/mpi
ENV MKLROOT=/opt/intel/compilers_and_libraries_2018.4.057/linux/mkl
ENV DAALROOT=/opt/intel/compilers_and_libraries_2018.4.057/linux/daal
ENV TBBROOT=/opt/intel/compilers_and_libraries_2018.4.057/linux/tbb
ENV CPATH=/opt/intel/compilers_and_libraries_2018.4.057/linux/ipp/include:/opt/intel/compilers_and_libraries_2018.4.057/linux/mkl/include:/opt/intel/compilers_and_libraries_2018.4.057/linux/tbb/include:/opt/intel/compilers_and_libraries_2018.4.057/linux/daal/include

# Make sure the above SCLs are already enabled
ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "/usr/bin/scl", "enable", "devtoolset-7", "--", "/usr/bin/scl", "enable", "rh-git29", "--"]
CMD ["/bin/bash"]
