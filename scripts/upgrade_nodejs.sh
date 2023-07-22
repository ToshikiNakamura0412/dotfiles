#!/bin/sh

# nodejs
echo "========================================"
echo " nodejs will be installed and upgraded"
echo "========================================"
sudo apt install nodejs npm
sudo npm install -g n
sudo n stable
