#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

function install_prerequisites() {
    echo ""
    echo "======================="
    echo " install prerequisites"
    echo "======================="
    echo ""
    ${SCRIPT_DIR}/scripts/install_prerequisites.bash
}

function setup() {
    echo ""
    echo "======="
    echo " setup"
    echo "======="
    echo ""
    ${SCRIPT_DIR}/scripts/setup_git.bash
    ${SCRIPT_DIR}/scripts/setup_shell.bash
    ${SCRIPT_DIR}/scripts/setup_tmux.bash
}

function main() {
    install_prerequisites
    setup
    echo ""
    echo "please set your terminal font as 'Hack Nerd Font Regular'"
}

main
