#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo ""
echo "setting git... "
if [ -e ~/.gitconfig ]; then
    SETTING_COUNT1=$(cat ~/.gitconfig | grep alias | wc -l)
    # SETTING_COUNT2=$(cat ~/.gitconfig | grep url | wc -l)
    # if [ $SETTING_COUNT1 -eq 0 ] || [ $SETTING_COUNT2 -eq 0 ]; then
    if [ $SETTING_COUNT1 -eq 0 ]; then
        cat $SCRIPT_DIR/gitconfig >> ~/.gitconfig
    fi
else
    cat $SCRIPT_DIR/gitconfig > ~/.gitconfig
fi
if [ ! -d ~/.config/git ]; then
    mkdir -p -v ~/.config/git
fi
ln -siv $SCRIPT_DIR/gitignore ~/.config/git/ignore
echo ">>> Done"
echo ""
