#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
source $SCRIPT_DIR/common.bash

function setup_git() {
    local distro=$(get_distro)

    echo ""
    echo "setting git... "
    if [[ -e ~/.gitconfig ]]; then
        if ! grep -Fq "alias" ~/.gitconfig; then
            cat $SCRIPT_DIR/gitconfig >> ~/.gitconfig
        fi
    else
        cat $SCRIPT_DIR/gitconfig > ~/.gitconfig
    fi
    if [[ ! -d ~/.config/git ]]; then
        mkdir -p -v ~/.config/git
    fi
    if [[ ${distro} == "alpine" ]]; then
        ln -sv $SCRIPT_DIR/gitignore ~/.config/git/ignore
    elif is_valid_distro ${distro}; then
        ln -siv $SCRIPT_DIR/gitignore ~/.config/git/ignore
    fi
    echo ">>> Done"
    echo ""
}

function main() {
    check_os
    setup_git
}

main
