#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

# font
echo "=============================="
echo " nerd-fonts will be installed"
echo "=============================="
if [ ! -d ~/.local/share/fonts ]; then
    mkdir -p -v ~/.local/share/fonts
fi
if [ ! -e ~/.local/share/fonts/HackNerdFont-Regular.ttf ]; then
    cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf
fi
echo ">>> Done"
echo ""

echo "======="
echo " Setup"
echo "======="

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
echo "setting tmux... "
if [ -d ~/.tmux ]; then
    rm -rf ~/.tmux
fi
ln -sfv $SCRIPT_DIR/tmux.conf ~/.tmux.conf
git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins
echo ">>> Done"
echo ""

# Neovim
echo "setting Neovim... "
if [ -d ~/.local/share/nvim/plugged ]; then
    rm -rf ~/.local/share/nvim/plugged
fi
if [ -d ~/.config/nvim/undo ]; then
    rm -rf ~/.config/nvim/undo
fi
if [ -d ~/.config/coc ]; then
    rm -rf ~/.config/coc
fi
if [ ! -d ~/.config/nvim ]; then
    mkdir -pv ~/.config/nvim
fi
ln -sfv $SCRIPT_DIR/nvim/init.vim ~/.config/nvim/init.vim
ln -sfv $SCRIPT_DIR/nvim/configs/basic-settings.vim ~/.config/nvim/basic-settings.vim
ln -sfv $SCRIPT_DIR/nvim/configs/keymap.vim ~/.config/nvim/keymap.vim
ln -sfv $SCRIPT_DIR/nvim/configs/plugin-keymap.vim ~/.config/nvim/plugin-keymap.vim
ln -sfv $SCRIPT_DIR/nvim/configs/plugin-settings.vim ~/.config/nvim/plugin-settings.vim
ln -sfv $SCRIPT_DIR/nvim/configs/plugin.vim ~/.config/nvim/plugin.vim
ln -sfv $SCRIPT_DIR/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -sfv $SCRIPT_DIR/nvim/clang-format ~/.clang-format
echo ">>> Done"
echo ""

# setup coc extensions
$SCRIPT_DIR/scripts/setup_coc.sh
# setup fzf for Neovim
$SCRIPT_DIR/scripts/setup_fzf.sh

echo ""
echo "==="
echo "Finish!!"
echo "please set your terminal font as 'Hack Nerd Font Regular'"
echo "==="
echo "(If you want to upgrade Neovim, please refer to README.md)"
