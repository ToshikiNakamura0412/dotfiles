#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

# bashrc
if [ -f ~/.bashrc ]; then
    echo -n "setting config for bash... "
    echo "# Set ROS Noetic" >> ~/.bashrc
    # echo "source $SCRIPT_DIR/rosconfig" >> ~/.bashrc
    echo "source $SCRIPT_DIR/aliases" > ~/.bash_aliases
    echo "# auto start tmux" >> ~/.bashrc
    echo "source $SCRIPT_DIR/auto_tmux" >> ~/.bashrc
    echo "Done"
fi


# zshrc
if [ -f ~/.zshrc ]; then
    echo -n "setting config for zsh... "
    echo "# Set ROS Noetic" >> ~/.zshrc
    # echo "source $SCRIPT_DIR/rosconfig" >> ~/.zshrc
    echo "# Set aliases" >> ~/.zshrc
    echo "source $SCRIPT_DIR/aliases" >> ~/.zshrc
    echo "# auto start tmux" >> ~/.zshrc
    echo "source $SCRIPT_DIR/auto_tmux" >> ~/.zshrc
    echo "Done"
fi


# gitconfig
echo -n "setting git aliases... "
if [ -f ~/.gitconfig ]; then
    cat $SCRIPT_DIR/gitconfig >> ~/.gitconfig
else
    cat $SCRIPT_DIR/gitconfig > ~/.gitconfig
fi
echo "Done"


# tmux
echo -n "setting tmux... "
echo "source $SCRIPT_DIR/tmux.conf" > ~/.tmux.conf
echo "source-file $SCRIPT_DIR/tmux.session.conf" > ~/.tmux.session.conf
echo "Done"


# vim
echo "setting vim... "
echo "source $SCRIPT_DIR/vimrc" > ~/.vimrc
if [ -d ~/.vim/undo ]; then
    echo "~/.vim/undo exists"
else
    mkdir -p -v ~/.vim/undo
fi
echo ">>> Done"


# neovim
echo "setting neovim... "
if [ -d ~/.config/nvim ]; then
    echo "~/.config/nvim exists"
else
    mkdir -p -v ~/.config/nvim
fi
echo "source $SCRIPT_DIR/init.vim" > ~/.config/nvim/init.vim
echo "source $SCRIPT_DIR/coc-settings.json" > ~/.config/nvim/coc-settings.json
echo ">>> Done"


echo "==="
echo "Finish!"
echo "==="
