#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TESTS_DIR="$(realpath $SCRIPT_DIR/..)"

source $TESTS_DIR/support/bash_colours

function main() {
    local option="${1:-notarget}"

    case $option in
        --all)     test_all  ;;
        --html)    test_html ;;
        --pdf)     test_pdf  ;;
        -h|--help) test_help ; exit 0 ;;
        *)         test_help ; exit 1 ;;
    esac
}

function test_help() {
    echo "Usage: ./test.sh <option>"
    echo "  --all      Test HTML and PDF outputs"
    echo "  --html     Test HTML output"
    echo "  --pdf      Test PDF output"
    echo "  -h|--help  Print this message"
}

function test_html() {
    echo -e "${BOLD_YELLOW}========== Testing HTML generation =============================================${TXT_RESET}"

    echo -e "Deleting directory '$SCRIPT_DIR/build'"
    rm -rf "$SCRIPT_DIR/build"

    cp -f $SCRIPT_DIR/source/index.rst.template $SCRIPT_DIR/source/index.rst

    echo -e "Generating documentation in '$SCRIPT_DIR/build'"
    echo -e "${BOLD_YELLOW}Output redirected to '$SCRIPT_DIR/logs/html.log' ${TXT_RESET}"
    docker run -it --rm -v $SCRIPT_DIR:/doc -e USER_ID=$UID ddidier/sphinx-doc make html > $SCRIPT_DIR/logs/html.log


    if [ -d "$SCRIPT_DIR/build/html" ]; then
        local delta=$(diff -r --exclude "_images" $SCRIPT_DIR/build/html $SCRIPT_DIR/expected/html)

        if [ "$delta" == "" ]; then
            local image_error=0

            # actdiag includes some hash in the image
            local file_name_prefix=actdiag
            local actual_image=$(find $SCRIPT_DIR/build/html/_images/ -name "${file_name_prefix}-*.png")
            local expected_image=$(find $SCRIPT_DIR/expected/html/_images/ -name "${file_name_prefix}-*.png")
            local image_delta=$(compare -metric AE "$actual_image" "$expected_image" /tmp/${file_name_prefix}-diff.png 2>&1)
            local image_delta=$(expr $image_delta + 0)

            # 460 pixels = 0.5%
            if [ $image_delta -gt 460 ]; then
                echo -en "$BOLD_RED"
                echo -en "Number of different pixels for '$file_name_prefix' images: $image_delta"
                echo -e  "$TXT_RESET"
                image_error=1
            else
                echo -e "Number of different pixels for '$file_name_prefix' images: $image_delta"
            fi

            # blockdiag, nwdiag, rackdiag and seqdiag filenames include hashes that change every time
            # but there is only one of each type
            for file_name_prefix in blockdiag nwdiag rackdiag seqdiag; do
                local actual_image=$(find $SCRIPT_DIR/build/html/_images/ -name "${file_name_prefix}-*.png")
                local expected_image=$(find $SCRIPT_DIR/expected/html/_images/ -name "${file_name_prefix}-*.png")
                local image_delta=$(compare -metric AE "$actual_image" "$expected_image" /tmp/${file_name_prefix}-diff.png 2>&1)
                local image_delta=$(expr $image_delta + 0)

                if [ $image_delta -gt 0 ]; then
                    echo -en "$BOLD_RED"
                    echo -en "Number of different pixels for '$file_name_prefix' images: $image_delta"
                    echo -e  "$TXT_RESET"
                    image_error=1
                else
                    echo -e "Number of different pixels for '$file_name_prefix' images: $image_delta"
                fi
            done

            # plantuml filename include a hash representing the content
            for file_path in $(find $SCRIPT_DIR/expected/html/_images/ -name "plantuml-*.png"); do
                local file_name=$(basename $file_path)
                if [ -f $SCRIPT_DIR/build/html/_images/$file_name ]; then
                    echo "Found matching file for '$file_name'"
                else
                    echo -en "$BOLD_RED"
                    echo -en "No matching file found for '$file_name'"
                    echo -e  "$TXT_RESET"
                    image_error=1
                fi
            done

            if [ $image_error -eq 0 ]; then
                echo -e $BOLD_GREEN
                echo -e " ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
                echo -e " ┃ HTML Test: Success                                                         "
                echo -e " ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
                echo -e $TXT_RESET
            else
                echo -e $BOLD_RED
                echo -e " ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
                echo -e " ┃ HTML Test: Failed                                                          "
                echo -e " ┃ At least one image was different (see above)                               "
                echo -e " ┃ Logs were generated in '$SCRIPT_DIR/logs/html.log'                         "
                echo -e " ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
                echo -e $TXT_RESET
                exit 1
            fi
        else
            echo -e $BOLD_RED
            echo -e " ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo -e " ┃ HTML Test: Failed                                                          "
            echo -e " ┃ Some useful commands:                                                      "
            echo -e " ┃   diff -r $SCRIPT_DIR/build/html $SCRIPT_DIR/expected/html                 "
            echo -e " ┃   meld $SCRIPT_DIR/build/html $SCRIPT_DIR/expected/html &                  "
            echo -e " ┃ Logs were generated in '$SCRIPT_DIR/logs/html.log'                         "
            echo -e " ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo -e $TXT_RESET
            exit 1
        fi
    else
        echo -e $BOLD_RED
        echo -e " ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo -e " ┃ HTML Test: Failed                                                          "
        echo -e " ┃ Directory '$SCRIPT_DIR/build/html' does not exist                          "
        echo -e " ┃ Logs were generated in '$SCRIPT_DIR/logs/html.log'                         "
        echo -e " ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo -e $TXT_RESET
        exit 1
    fi
}

function test_pdf() {
    echo -e "${BOLD_YELLOW}========== Testing PDF generation ==============================================${TXT_RESET}"

    echo -e "Deleting directory '$SCRIPT_DIR/build'"
    rm -rf "$SCRIPT_DIR/build"

    cp -f $SCRIPT_DIR/source/index.rst.template $SCRIPT_DIR/source/index.rst
    sed -i '/Markdown document/d' $SCRIPT_DIR/source/index.rst

    echo -e "Generating documentation in '$SCRIPT_DIR/build'"
    echo -e "${BOLD_YELLOW}Output redirected to '$SCRIPT_DIR/logs/pdf.log' ${TXT_RESET}"
    docker run -it --rm -v $SCRIPT_DIR:/doc -e USER_ID=$UID ddidier/sphinx-doc make latexpdf > $SCRIPT_DIR/logs/pdf.log

    if [ -f "$SCRIPT_DIR/build/latex/NDDDockerSphinxTest.pdf" ]; then
        echo -e $BOLD_PURPLE
        echo -e " ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo -e " ┃ PDF Test: No way to test the generated document                            "
        echo -e " ┃ The PDF was generated in '$SCRIPT_DIR/build/latex/NDDDockerSphinxTest.pdf' "
        echo -e " ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo -e $TXT_RESET
    else
        echo -e $BOLD_RED
        echo -e " ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo -e " ┃ PDF Test: Failed                                                           "
        echo -e " ┃ The PDF was NOT generated in $SCRIPT_DIR/build/latex                       "
        echo -e " ┃ Logs were generated in '$SCRIPT_DIR/logs/html.log'                         "
        echo -e " ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo -e $TXT_RESET
    fi
}

function test_all() {
    test_html
    test_pdf
}

main "$@"
