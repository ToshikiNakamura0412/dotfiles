#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

# git
echo -n "setting git... "
if [ -e ~/.gitconfig ]; then
    cat $SCRIPT_DIR/gitconfig >> ~/.gitconfig
else
    cat $SCRIPT_DIR/gitconfig > ~/.gitconfig
fi
if [ ! -d ~/.config/git ]; then
    mkdir -p -v ~/.config/git
fi
ln -sf $SCRIPT_DIR/gitignore ~/.config/git/ignore
echo "Done"
echo ""

# shell, tmux, vim, neovim
cd $SCRIPT_DIR && ./update.sh
