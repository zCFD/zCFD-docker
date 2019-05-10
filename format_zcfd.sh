#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

pushd $SCRIPT_DIR

docker run -it --rm  -v $SCRIPT_DIR/../:/workdir/zCFD unibeautify/clang-format clang-format -i --style=google --verbose $(cd $SCRIPT_DIR/../ && git ls-files | sed -e 's,^,zCFD/,' | grep -e\\\.cpp\$ -e\\\.cu\$ -e\\\.h\$ -e\\\.cxx\$)

popd