#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

# git
if [ ! -d ~/.config/git ]; then
    mkdir -p -v ~/.config/git
fi
ln -sf $SCRIPT_DIR/scripts/gitignore ~/.config/git/ignore

# shell
echo -n "setting shell... "
if [ -e ~/.bashrc ]; then # bashrc
    LOAD_COMMAND_COUNT=$(cat ~/.bashrc | grep dotfiles\/scripts\/load_files\.sh | wc -l)
    if [ $LOAD_COMMAND_COUNT -eq 0 ]; then
        echo "source $SCRIPT_DIR/scripts/load_files.sh" >> ~/.bashrc
    fi
fi
if [ -e ~/.zshrc ]; then # zshrc
    LOAD_COMMAND_COUNT=$(cat ~/.zshrc | grep dotfiles\/scripts\/load_files\.sh | wc -l)
    if [ $LOAD_COMMAND_COUNT -eq 0 ]; then
        echo "source $SCRIPT_DIR/scripts/load_files.sh" >> ~/.zshrc
    fi
fi
echo "Done"
echo ""

# tmux
echo -n "setting tmux... "
ln -sf $SCRIPT_DIR/tmux/tmux.conf ~/.tmux.conf
ln -sf $SCRIPT_DIR/tmux/tmux.session.conf ~/.tmux.session.conf
echo "Done"
echo ""

# vim
echo "setting vim... "
if [ -d ~/.vim/undo ]; then
    rm -rf ~/.vim/undo
fi
if [ -d ~/.vim/plugged ]; then
    rm -rf ~/.vim/plugged
fi
mkdir -p -v ~/.vim/undo
ln -sf $SCRIPT_DIR/vim/vimrc ~/.vimrc
ln -sf $SCRIPT_DIR/vim/coc-settings.json ~/.vim/coc-settings.json
echo ">>> Done"
echo ""

# neovim
echo "setting neovim... "
if [ -d ~/.local/share/nvim ]; then
    rm -rf ~/.local/share/nvim
fi
if [ -d ~/.config/nvim/undo ]; then
    rm -rf ~/.config/nvim/undo
fi
if [ -d ~/.local/share/nvim/plugged ]; then
    rm -rf ~/.local/share/nvim/plugged
fi
if [ -d ~/.config/coc ]; then
    rm -rf ~/.config/coc
fi
if [ ! -d ~/.config/nvim ]; then
    mkdir -p -v ~/.config/nvim
fi
ln -sf $SCRIPT_DIR/vim/init.vim ~/.config/nvim/init.vim
ln -sf $SCRIPT_DIR/vim/coc-settings.json ~/.config/nvim/coc-settings.json
echo ">>> Done"
echo ""

# setup_coc_extensions
cd $SCRIPT_DIR/scripts && ./setup_coc_extensions.sh

echo ""
echo "==="
echo "Finish!!"
echo "==="
echo "(If you want to upgrade Vim or Neovim, please refer to README.md)"
