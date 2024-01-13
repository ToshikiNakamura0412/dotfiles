#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

# libfuse2
source /etc/os-release
OS_NAME=$(echo $ID$VERSION_ID | cut -d '.' -f 1)
if [ $OS_NAME = "ubuntu22" ]; then
    echo "============================"
    echo " libfuse2 will be installed"
    echo "============================"
    sudo apt install -y --no-install-recommends libfuse2
    echo ">>> Done"
    echo ""
fi

# neovim
echo "========================================"
echo " neovim will be installed and upgraded"
echo "========================================"
sudo wget -O /opt/nvim.appimage https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
sudo chmod +x /opt/nvim.appimage
sudo ln -sf /opt/nvim.appimage /usr/bin/vim
sudo ln -sf /opt/nvim.appimage /usr/bin/nvim
sudo apt install -y --no-install-recommends xsel
echo ">>> Done"
echo ""

