#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TESTS_DIR="$(realpath $SCRIPT_DIR/..)"

source $TESTS_DIR/support/bash_colours

function main() {
    local build_dir="$SCRIPT_DIR/build"

    echo -e "${BOLD_YELLOW}========== Testing initialization ==============================================${TXT_RESET}"

    echo -e "Deleting directory '$build_dir'"
    rm -rf "$build_dir"
    mkdir "$build_dir"

    echo -e "Generating project in '$build_dir'"
    echo -e "${BOLD_YELLOW}Output redirected to '$SCRIPT_DIR/logs/html.log' ${TXT_RESET}"
    docker run -it --rm -v $build_dir:/doc -e USER_ID=$UID ddidier/sphinx-doc \
        sphinx-init --project=MYPROJECT --author=MYSELF --sep --quiet \
         > $SCRIPT_DIR/logs/html.log

    echo -e "Generating HTML documentation"
    "$build_dir/bin/make-html"

    # get rid of the generation date
    sed -i -E 's/(sphinx-quickstart on) .+/\1 XXXXXXXXXX./g' $SCRIPT_DIR/build/source/index.rst
    sed -i -E 's/(sphinx-quickstart on) .+/\1 XXXXXXXXXX./g' $SCRIPT_DIR/build/build/html/_sources/index.rst.txt
    # get rid of the image tag
    sed -i -E "s/(ddidier_sphinxdoc_image_tag =) '[0-9a-f]+'/\1 '0123456789ABCDEF'/g" $SCRIPT_DIR/build/source/conf.py

    # compute differences
    local delta=$(diff -r --exclude "doctrees" $SCRIPT_DIR/build $SCRIPT_DIR/expected)

    if [ "$delta" == "" ]; then
        echo -e $BOLD_GREEN
        echo -e " ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo -e " ┃ HTML Test: Success                                                         "
        echo -e " ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo -e $TXT_RESET
    else
        echo -e $BOLD_RED
        echo -e " ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo -e " ┃ HTML Test: Failed                                                          "
        echo -e " ┃ Some useful commands:                                                      "
        echo -e " ┃   diff -r --exclude \"doctrees\" $SCRIPT_DIR/build $SCRIPT_DIR/expected    "
        echo -e " ┃   meld $SCRIPT_DIR/build $SCRIPT_DIR/expected &                            "
        echo -e " ┃ Logs were generated in '$SCRIPT_DIR/logs/html.log'                         "
        echo -e " ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo -e $TXT_RESET
        exit 1
    fi
}

main "$@"
