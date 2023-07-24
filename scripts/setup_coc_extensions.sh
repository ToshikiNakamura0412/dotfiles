#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

# C/C++
echo "=========================="
echo " clangd will be installed"
echo "=========================="
sudo apt install clangd -y
echo ">>> Done"
echo ""

# Python
echo "========================================"
echo " jedi-language-server will be installed"
echo "========================================"
sudo apt install python3-pip -y
pip3 install jedi-language-server
echo ">>> Done"
echo ""

# Node.js
cd $SCRIPT_DIR && ./upgrade_nodejs.sh
