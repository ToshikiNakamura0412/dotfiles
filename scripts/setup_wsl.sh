#!/bin/bash

sudo apt -y install language-pack-ja
sudo update-locale LANG=ja_JP.UTF8
sudo apt -y install manpages-ja manpages-ja-dev

# Set display settings
if [ -e ~/.bashrc ]; then # bashrc
    echo "export DISPLAY=\$(cat /etc/resolv.conf | grep nameserver | awk '{print \$2}'):0" >> ~/.bashrc
    echo "export LIBGL_ALWAYS_SOFTWARE=1" >> ~/.bashrc
fi
if [ -e ~/.zshrc ]; then # zshrc
    echo "export DISPLAY=\$(cat /etc/resolv.conf | grep nameserver | awk '{print \$2}'):0" >> ~/.zshrc
    echo "export LIBGL_ALWAYS_SOFTWARE=1" >> ~/.zshrc
fi
echo "Done"
echo ""
