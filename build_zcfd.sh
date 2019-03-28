#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

pushd $SCRIPT_DIR

#docker build centos-7 -t registry.zenotech.com/zcfd/dev

docker run -it --rm -e INTEL_LICENSE_FILE=${INTEL_LICENSE_FILE} -v zcfd-dev:/home/dev/BUILD -v $SCRIPT_DIR/../:/home/dev/zCFD -v ~/.gitconfig:/home/dev/.gitconfig -v ~/.ssh:/home/dev/.ssh registry.zenotech.com/zcfd/dev bash -c "source /opt/intel/parallel_studio_xe_2018/psxevars.sh && /home/dev/zCFD/scripts/build_zcfd.bsh -g --download-dir /home/dev/BUILD/downloads/ $*"

popd