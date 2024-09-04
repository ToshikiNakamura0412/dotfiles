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

if [ $OS_NAME = "ubuntu" ] || [ $OS_NAME = "debian" ]; then
    sudo apt-get update && sudo apt-get install -y --no-install-recommends \
        zsh \
        curl \
        tmux
elif [ $OS_NAME = "alpine" ]; then
    sudo apk update && sudo apk add \
        zsh \
        curl \
        tmux
elif [ $OS_NAME = "fedora" ]; then
    sudo dnf check-update || true && sudo dnf install -y \
        zsh \
        curl \
        tmux
elif [ $OS_NAME = "opensuse-leap" ]; then
    sudo zypper refresh && sudo zypper install -y --no-recommends \
        zsh \
        curl \
        tmux
elif [ $OS_NAME = "mac" ]; then
    brew install \
        tmux
fi

# Vim/Neovim
$SCRIPT_DIR/../nvim/configs/basic/install.sh
$SCRIPT_DIR/../nvim/install.sh
