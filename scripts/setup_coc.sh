#!/bin/sh

# C/C++
echo "=========================="
echo " clangd will be installed"
echo "=========================="
sudo apt install clangd -y --no-install-recommends
echo ">>> Done"
echo ""

# Python
echo "========================================"
echo " jedi-language-server will be installed"
echo "========================================"
sudo apt install python3-pip -y --no-install-recommends
pip3 install jedi-language-server
echo ">>> Done"
echo ""

# Node.js
echo "========================================"
echo " nodejs will be installed and upgraded"
echo "========================================"
sudo apt install nodejs npm -y --no-install-recommends
sudo npm install -g n
sudo n stable
echo ">>> Done"
echo ""
