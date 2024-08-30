#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)
OS_NAME=$1
if [ -z $OS_NAME ]; then
    source /etc/os-release
    OS_NAME=$(echo $ID)
fi

# shell
echo -n "setting shell... "
if [ -e ~/.bashrc ]; then # bashrc
    LOAD_COMMAND_COUNT=$(cat ~/.bashrc | grep dotfiles\/scripts\/my_conf\.sh | wc -l)
    if [ $LOAD_COMMAND_COUNT -eq 0 ]; then
        echo "" >> ~/.bashrc
        echo "# dotfiles" >> ~/.bashrc
        echo "source $SCRIPT_DIR/scripts/my_conf.sh" >> ~/.bashrc
    fi
fi
if [ -e ~/.zshrc ]; then # zshrc
    LOAD_COMMAND_COUNT=$(cat ~/.zshrc | grep dotfiles\/scripts\/my_conf\.sh | wc -l)
    if [ $LOAD_COMMAND_COUNT -eq 0 ]; then
        echo "" >> ~/.zshrc
        echo "# dotfiles" >> ~/.zshrc
        echo "source $SCRIPT_DIR/scripts/my_conf.sh" >> ~/.zshrc
    fi
fi
echo "Done"
echo ""

# zsh
if [ $OS_NAME = "ubuntu" ] || [ $OS_NAME = "debian" ]; then
    echo "install zsh... "
    sudo apt-get update && sudo apt-get install -y --no-install-recommends zsh
fi
$SCRIPT_DIR/scripts/setup_zsh.sh $OS_NAME

# git
$SCRIPT_DIR/scripts/setup_git.sh

# tmux
if [ $OS_NAME = "ubuntu" ] || [ $OS_NAME = "debian" ]; then
    echo "install tmux... "
    sudo apt-get update && sudo apt-get install -y --no-install-recommends tmux
    echo ">>> Done"
    echo ""
elif [ $OS_NAME = "alpine" ]; then
    echo "install tmux... "
    sudo apk update && sudo apk add tmux
    echo ">>> Done"
    echo ""
elif [ $OS_NAME = "mac" ]; then
    echo "install tmux... "
    brew install tmux
    echo ">>> Done"
    echo ""
fi
$SCRIPT_DIR/scripts/setup_tmux.sh

# Neovim
echo "install Neovim... "
$SCRIPT_DIR/nvim/install.sh

echo ""
echo "please set your terminal font as 'Hack Nerd Font Regular'"
