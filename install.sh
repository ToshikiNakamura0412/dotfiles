#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

# bashrc
if [ -f ~/.bashrc ]; then
    echo -n "setting config for bash... "
    echo "source $SCRIPT_DIR/aliases" > ~/.bash_aliases
    echo "# auto start tmux" >> ~/.bashrc
    echo "source $SCRIPT_DIR/auto_tmux" >> ~/.bashrc
    echo "Done"
fi


# zshrc
if [ -f ~/.zshrc ]; then
    echo -n "setting config for zsh... "
    echo "# Set aliases" >> ~/.zshrc
    echo "source $SCRIPT_DIR/aliases" >> ~/.zshrc
    echo "# auto start tmux" >> ~/.zshrc
    echo "source $SCRIPT_DIR/auto_tmux" >> ~/.zshrc
    echo "Done"
fi


# tmux
echo -n "setting tmux... "
echo "source $SCRIPT_DIR/tmux.conf" > ~/.tmux.conf
echo "Done"


# vim
echo "setting vim... "
echo "source $SCRIPT_DIR/vimrc" > ~/.vimrc

if [ -d ~/.vim/undo ]; then
    echo "~/.vim/undo exists"
else
    mkdir -p -v ~/.vim/undo
fi

if [ -d ~/.vim/plugged ]; then
    echo "~/.vim/plugged exists"
else
    mkdir -p -v ~/.vim/plugged
fi

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [ -d ~/.config/nvim ]; then
    echo "~/.config/nvim exists"
else
    mkdir -p -v ~/.config/nvim
fi
echo "source $SCRIPT_DIR/init.vim" > ~/.config/nvim/init.vim
echo ">>> Done"


echo "==="
echo "please open vim and run ':PlugInstall'"
echo "==="
