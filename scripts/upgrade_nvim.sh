#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

# neovim
echo "========================================"
echo " neovim will be installed and upgraded"
echo "========================================"
sudo wget -O /opt/nvim.appimage https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
sudo chmod +x /opt/nvim.appimage
sudo ln -sf /opt/nvim.appimage /usr/bin/vim
sudo ln -sf /opt/nvim.appimage /usr/bin/nvim
sudo apt install xsel -y --no-install-recommends
echo ">>> Done"
echo ""

