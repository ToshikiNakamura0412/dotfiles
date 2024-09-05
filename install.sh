#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo ""
echo "========="
echo " install"
echo "========="
echo ""
$SCRIPT_DIR/scripts/install_prerequisites.bash

echo ""
echo "======="
echo " setup"
echo "======="
echo ""
$SCRIPT_DIR/scripts/setup_git.bash
$SCRIPT_DIR/scripts/setup_shell.bash
$SCRIPT_DIR/scripts/setup_tmux.bash

echo ""
echo "please set your terminal font as 'Hack Nerd Font Regular'"
