#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

pushd $SCRIPT_DIR

docker build centos-6 -t zcfd/dev

docker run -it --rm  -v zcfd-dev:/home/dev/BUILD -v $SCRIPT_DIR/../:/home/dev/zCFD -v ~/.ssh:/home/dev/.ssh -e PATH+=/usr/lib64/openmpi/bin/ zcfd/dev /home/dev/zCFD/scripts/build_zcfd.bsh -g $*

popd