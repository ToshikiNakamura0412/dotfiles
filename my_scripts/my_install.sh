#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

# git
echo -n "setting git... "
if [ -e ~/.gitconfig ]; then
    cat $SCRIPT_DIR/../scripts/gitconfig >> ~/.gitconfig
else
    cat $SCRIPT_DIR/../scripts/gitconfig > ~/.gitconfig
fi
echo "Done"
echo ""

# shell, tmux, vim, neovim
cd $SCRIPT_DIR && ./my_update.sh
