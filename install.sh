#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
OS_NAME=$1
if [ -z $OS_NAME ]; then
    source /etc/os-release
    OS_NAME=$(echo $ID)
fi

echo ""
echo "========="
echo " install"
echo "========="
echo ""
$SCRIPT_DIR/scripts/install_prerequisites.sh $OS_NAME

echo ""
echo "======="
echo " setup"
echo "======="
echo ""
$SCRIPT_DIR/scripts/setup_git.sh
$SCRIPT_DIR/scripts/setup_shell.sh $OS_NAME
$SCRIPT_DIR/scripts/setup_tmux.sh

echo ""
echo "please set your terminal font as 'Hack Nerd Font Regular'"
