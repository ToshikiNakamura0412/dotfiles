#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
source ${SCRIPT_DIR}/common.bash

PKGS=(
    "zsh"
    "curl"
    "tmux"
)
PKGS2=(
    "zsh"
    "curl-minimal"
    "tmux"
)

function install_prerequisites(){
    local distro=$(get_distro)
    if [[ ${distro} == "ubuntu" ]] || [[ ${distro} == "debian" ]]; then
        sudo apt-get update && sudo apt-get install -y --no-install-recommends ${PKGS[@]}
    elif [[ ${distro} == "alpine" ]]; then
        sudo apk update && sudo apk add --no-cache ${PKGS[@]}
    elif [[ ${distro} == "arch" ]]; then
        sudo pacman -Sy --noconfirm  ${PKGS[@]}
    elif [[ ${distro} == "fedora" ]]; then
        sudo dnf check-update || true && sudo dnf install -y --setopt=install_weak_deps=False ${PKGS[@]}
    elif [[ ${distro} == "centos" ]]; then
        sudo dnf check-update || true && sudo dnf install -y --setopt=install_weak_deps=False ${PKGS2[@]}
    elif [[ ${distro} == "opensuse-leap" ]]; then
        sudo zypper refresh && sudo zypper install -y --no-recommends ${PKGS[@]}
    elif [[ ${distro} == "mac" ]]; then
        brew install \
            tmux
    fi
    ${SCRIPT_DIR}/../nvim/configs/basic/install.sh
    ${SCRIPT_DIR}/../nvim/install.sh
}

function main() {
    check_os
    install_prerequisites
}

main
