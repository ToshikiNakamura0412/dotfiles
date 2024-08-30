#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
OS_NAME=$1
if [ -z $OS_NAME ]; then
    source /etc/os-release
    OS_NAME=$(echo $ID)
fi

if [ $OS_NAME = "ubuntu" ] || [ $OS_NAME = "debian" ]; then
    sudo apt-get update && sudo apt-get install -y --no-install-recommends \
        zsh \
        tmux
elif [ $OS_NAME = "alpine" ]; then
    sudo apk update && sudo apk add \
        tmux
elif [ $OS_NAME = "mac" ]; then
    brew install \
        tmux
fi

# Vim/Neovim
$SCRIPT_DIR/../nvim/configs/basic/install.sh $OS_NAME
$SCRIPT_DIR/../nvim/install.sh $OS_NAME
