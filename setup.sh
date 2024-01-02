#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo "======="
echo " Setup"
echo "======="

# git
echo -n "setting git... "
if [ ! -e ~/.gitconfig ]; then
    cat $SCRIPT_DIR/scripts/gitconfig > ~/.gitconfig
fi
if [ ! -d ~/.config/git ]; then
   mkdir -p -v ~/.config/git
fi
ln -sf $SCRIPT_DIR/scripts/gitignore ~/.config/git/ignore
echo "Done"
echo ""

# shell
echo -n "setting shell... "
if [ -e ~/.bashrc ]; then # bashrc
    LOAD_COMMAND_COUNT=$(cat ~/.bashrc | grep dotfiles\/scripts\/load_files\.sh | wc -l)
    if [ $LOAD_COMMAND_COUNT -eq 0 ]; then
        echo "" >> ~/.bashrc
        echo "# dotfiles" >> ~/.bashrc
        echo "source $SCRIPT_DIR/scripts/load_files.sh" >> ~/.bashrc
    fi
fi
if [ -e ~/.zshrc ]; then # zshrc
    LOAD_COMMAND_COUNT=$(cat ~/.zshrc | grep dotfiles\/scripts\/load_files\.sh | wc -l)
    if [ $LOAD_COMMAND_COUNT -eq 0 ]; then
        echo "" >> ~/.zshrc
        echo "# dotfiles" >> ~/.zshrc
        echo "source $SCRIPT_DIR/scripts/load_files.sh" >> ~/.zshrc
    fi
fi
echo "Done"
echo ""

# tmux
echo -n "setting tmux... "
if [ -d ~/.tmux ]; then
    rm -rf ~/.tmux
fi
ln -sf $SCRIPT_DIR/tmux.conf ~/.tmux.conf
echo "Done"
echo ""

# Neovim
echo "setting Neovim... "
if [ -d ~/.local/share/nvim/plugged ]; then
    rm -rf ~/.local/share/nvim/plugged
fi
if [ -d ~/.config/coc ]; then
    rm -rf ~/.config/coc
fi
if [ ! -d ~/.config/nvim ]; then
    mkdir -p -v ~/.config/nvim
fi
ln -sf $SCRIPT_DIR/nvim/init.vim ~/.config/nvim/init.vim
ln -sf $SCRIPT_DIR/nvim/configs/basic-settings.vim ~/.config/nvim/basic-settings.vim
ln -sf $SCRIPT_DIR/nvim/configs/keymap.vim ~/.config/nvim/keymap.vim
ln -sf $SCRIPT_DIR/nvim/configs/plugin-keymap.vim ~/.config/nvim/plugin-keymap.vim
ln -sf $SCRIPT_DIR/nvim/configs/plugin-settings.vim ~/.config/nvim/plugin-settings.vim
ln -sf $SCRIPT_DIR/nvim/configs/plugin.vim ~/.config/nvim/plugin.vim
ln -sf $SCRIPT_DIR/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -sf $SCRIPT_DIR/nvim/clang-format ~/.clang-format
echo ">>> Done"
echo ""

# setup_coc_extensions
$SCRIPT_DIR/scripts/setup_coc.sh

echo ""
echo "==="
echo "Finish!!"
echo "==="
echo "(If you want to upgrade Neovim, please refer to README.md)"
