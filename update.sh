#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

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
if [ ! -d ~/.vim/undo ]; then
    mkdir -p -v ~/.vim/undo
fi
ln -sf $SCRIPT_DIR/vim/vimrc ~/.vimrc
ln -sf $SCRIPT_DIR/vim/coc-settings.json ~/.vim/coc-settings.json
ln -sf $SCRIPT_DIR/vim/vimrc_for_vscode ~/.vim/vimrc_for_vscode
echo ">>> Done"
echo ""

# neovim
echo "setting neovim... "
if [ ! -d ~/.config/nvim ]; then
    mkdir -p -v ~/.config/nvim
fi
ln -sf $SCRIPT_DIR/vim/init.vim ~/.config/nvim/init.vim
ln -sf $SCRIPT_DIR/vim/coc-settings.json ~/.config/nvim/coc-settings.json
echo ">>> Done"
echo ""

# setup_coc_extensions
cd $SCRIPT_DIR/scripts && ./setup_coc_extensions.sh
