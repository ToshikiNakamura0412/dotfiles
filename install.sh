#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

# git
echo "setting git... "
if [ -e ~/.gitconfig ]; then
    cat $SCRIPT_DIR/gitconfig >> ~/.gitconfig
else
    cat $SCRIPT_DIR/gitconfig > ~/.gitconfig
fi
echo ">>> Done"
echo ""

# shell, tmux, vim, neovim
cd $SCRIPT_DIR && ./update.sh


echo ""
echo "==="
echo "Finish!"
echo "==="
