#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)

sudo add-apt-repository ppa:git-core/ppa
sudo apt update

echo ""
echo "======================"
echo " git will be upgraded"
echo "======================"
echo ""
sudo apt install git -y --no-install-recommends
sudo rm /etc/apt/sources.list.d/git-core-ubuntu-ppa-focal.list*
sudo apt update
echo ">>> Done"
echo ""
