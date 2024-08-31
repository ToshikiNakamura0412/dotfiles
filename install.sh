#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo ""
echo "========="
echo " install"
echo "========="
echo ""
$SCRIPT_DIR/scripts/install_prerequisites.sh

echo ""
echo "======="
echo " setup"
echo "======="
echo ""
$SCRIPT_DIR/scripts/setup_git.sh
$SCRIPT_DIR/scripts/setup_shell.sh
$SCRIPT_DIR/scripts/setup_tmux.sh

echo ""
echo "please set your terminal font as 'Hack Nerd Font Regular'"
