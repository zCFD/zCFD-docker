#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$SCRIPT_DIR/test-build/test.sh --all
$SCRIPT_DIR/test-init/test.sh
