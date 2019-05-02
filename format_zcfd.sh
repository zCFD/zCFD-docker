#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

pushd $SCRIPT_DIR

docker build centos-7 -t registry.zenotech.com/zcfd/dev

docker run -it --rm  -v zcfd-dev:/home/dev/BUILD -v $SCRIPT_DIR/../:/home/dev/zCFD -v ~/.gitconfig:/home/dev/.gitconfig -v ~/.ssh:/home/dev/.ssh registry.zenotech.com/zcfd/dev clang-format -i --style=google --verbose $(cd $SCRIPT_DIR/../ && git ls-files | sed -e 's,^,zCFD/,' | grep -e\\\.cpp\$ -e\\\.cu\$ -e\\\.h\$ -e\\\.cxx\$)

popd