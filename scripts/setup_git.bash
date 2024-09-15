#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
source ${SCRIPT_DIR}/common.bash

function install_diff_highlight() {
    if [[ ! -e /usr/share/doc/git/contrib/diff-highlight/diff-highlight ]]; then
        echo ""
        echo "installing diff-highlight..."
        sudo git clone --single-branch --depth 1 https://github.com/git/git.git /opt/git
        cd /opt/git/contrib/diff-highlight && sudo make
        sudo ln -sv /opt/git/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
        git config --global core.pager "diff-highlight | less"
        echo ">>> Done"
        echo ""
    fi
}

function setup_git() {
    local distro=$(get_distro)

    echo ""
    echo "setting git... "
    if [[ -e ~/.gitconfig ]]; then
        if ! grep -Fq "alias" ~/.gitconfig; then
            cat ${SCRIPT_DIR}/gitconfig >> ~/.gitconfig
        fi
    else
        cat ${SCRIPT_DIR}/gitconfig > ~/.gitconfig
    fi
    if [[ ! -d ~/.config/git ]]; then
        mkdir -p -v ~/.config/git
    fi
    if [[ ${distro} == "alpine" ]]; then
        ln -sv ${SCRIPT_DIR}/gitignore ~/.config/git/ignore
    elif is_valid_distro ${distro}; then
        ln -siv ${SCRIPT_DIR}/gitignore ~/.config/git/ignore
    fi
    echo ">>> Done"
    echo ""

    install_diff_highlight
}

function main() {
    check_os
    setup_git
}

main
