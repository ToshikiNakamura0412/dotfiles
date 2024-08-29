#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

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

# git
$SCRIPT_DIR/scripts/setup_git.sh

# tmux
echo "install tmux... "
sudo apt-get update && sudo apt-get install -y --no-install-recommends tmux
echo ">>> Done"
echo ""
$SCRIPT_DIR/scripts/setup_tmux.sh

# Neovim
echo "install Neovim... "
$SCRIPT_DIR/nvim/install.sh

echo ""
echo "please set your terminal font as 'Hack Nerd Font Regular'"
