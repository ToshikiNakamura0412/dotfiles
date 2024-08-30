#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
OS_NAME=$1
if [ -z $OS_NAME ]; then
    source /etc/os-release
    OS_NAME=$(echo $ID)
fi

echo ""
echo "setting zsh... "

if [ $OS_NAME = "ubuntu" ] || [ $OS_NAME = "debian" ] || [ $OS_NAME = "mac" ]; then
    echo ""
    echo "setting zsh... "
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ln -sfv $SCRIPT_DIR/../zsh/zshrc ~/.zshrc
    ln -sfv $SCRIPT_DIR/../zsh/p10k.zsh ~/.p10k.zsh
    ~/.fzf/install
fi

echo ">>> Done"
echo ""
