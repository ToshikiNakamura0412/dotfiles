#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

# git
echo "setting git... "
if [ -e ~/.gitconfig ]; then
    LOAD_COMMAND_COUNT=$(cat ~/.gitconfig | grep alias | wc -l)
    if [ $LOAD_COMMAND_COUNT -eq 0 ]; then
        cat $SCRIPT_DIR/scripts/gitconfig >> ~/.gitconfig
    fi
else
    cat $SCRIPT_DIR/scripts/gitconfig > ~/.gitconfig
fi
if [ ! -d ~/.config/git ]; then
   mkdir -p -v ~/.config/git
fi
ln -siv $SCRIPT_DIR/scripts/gitignore ~/.config/git/ignore
echo ">>> Done"
echo ""

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

# tmux
echo "install and setting tmux... "
sudo apt-get update && sudo apt-get install -y --no-install-recommends tmux
if [ -d ~/.tmux ]; then
    rm -rf ~/.tmux
fi
ln -sfv $SCRIPT_DIR/tmux.conf ~/.tmux.conf
git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins
echo ">>> Done"
echo ""

# Neovim
echo "install Neovim... "
if [ -d ~/.local/share/nvim/plugged ]; then
    rm -rf ~/.local/share/nvim/plugged
fi
if [ -d ~/.config/nvim/undo ]; then
    rm -rf ~/.config/nvim/undo
fi
if [ -d ~/.config/coc ]; then
    rm -rf ~/.config/coc
fi
$SCRIPT_DIR/nvim/install.sh

echo ""
echo "please set your terminal font as 'Hack Nerd Font Regular'"
