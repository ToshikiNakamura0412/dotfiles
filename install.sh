#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

# shell, tmux, vim, neovim
cd $SCRIPT_DIR && ./update.sh

# gitconfig
echo -n "setting git aliases... "
if [ -f ~/.gitconfig ]; then
    cat $SCRIPT_DIR/gitconfig >> ~/.gitconfig
else
    cat $SCRIPT_DIR/gitconfig > ~/.gitconfig
fi
echo ">>> Done"
echo ""


echo "==="
echo "Finish!"
echo "==="
