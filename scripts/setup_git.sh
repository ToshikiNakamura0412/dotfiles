#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
if [ "$(uname)" = "Linux" ]; then
    source /etc/os-release
    OS_NAME=$(echo $ID)
elif [ "$(uname)" = "Darwin" ]; then
    OS_NAME="mac"
else
    echo "This OS is not supported."
    exit 1
fi

echo ""
echo "setting git... "
if [ -e ~/.gitconfig ]; then
    SETTING_COUNT1=$(cat ~/.gitconfig | grep alias | wc -l)
    # SETTING_COUNT2=$(cat ~/.gitconfig | grep url | wc -l)
    # if [ $SETTING_COUNT1 -eq 0 ] || [ $SETTING_COUNT2 -eq 0 ]; then
    if [ $SETTING_COUNT1 -eq 0 ]; then
        cat $SCRIPT_DIR/gitconfig >> ~/.gitconfig
    fi
else
    cat $SCRIPT_DIR/gitconfig > ~/.gitconfig
fi
if [ ! -d ~/.config/git ]; then
    mkdir -p -v ~/.config/git
fi
if [ $OS_NAME = "ubuntu" ] || [ $OS_NAME = "debian" ] || [ $OS_NAME = "fedora" ] || [ $OS_NAME = "opensuse-leap" ] || [ $OS_NAME = "mac" ]; then
    ln -siv $SCRIPT_DIR/gitignore ~/.config/git/ignore
elif [ $OS_NAME = "alpine" ]; then
    ln -sv $SCRIPT_DIR/gitignore ~/.config/git/ignore
fi
echo ">>> Done"
echo ""
