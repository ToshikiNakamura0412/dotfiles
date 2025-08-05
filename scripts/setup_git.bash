#!/bin/bash

DOTFILES_SETUP_GIT_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${DOTFILES_SETUP_GIT_SCRIPT_DIR}/common.bash"

DOTFILES_SETUP_GIT_NO_INSTALL=false
if [[ "$1" == "--no-install" ]]; then
    DOTFILES_SETUP_GIT_NO_INSTALL=true
fi

dotfiles::install_diff_highlight() {
    if [[ ! -e /usr/share/doc/git/contrib/diff-highlight/diff-highlight ]]; then
        echo ""
        echo "[INFO] installing diff-highlight..."
        sudo git clone --single-branch --depth 1 https://github.com/git/git.git /opt/git
        cd /opt/git/contrib/diff-highlight && sudo make
        sudo ln -sv /opt/git/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
        git config --global core.pager "diff-highlight | less"
        echo "[INFO] >>> Done"
        echo ""
    fi
}

dotfiles::setup_git() {
    local distro="$(get_distro)"
    local script_dir="${DOTFILES_SETUP_GIT_SCRIPT_DIR}"
    local no_install="${DOTFILES_SETUP_GIT_NO_INSTALL}"

    echo ""
    echo "[INFO] setting git... "
    if [[ -e ~/.gitconfig ]]; then
        if ! grep -Fq "alias" ~/.gitconfig; then
            cat "${script_dir}/gitconfig" >> ~/.gitconfig
        fi
    else
        cat "${script_dir}/gitconfig" > ~/.gitconfig
    fi
    if [[ ! -d ~/.config/git ]]; then
        mkdir -p -v ~/.config/git
    fi
    if [[ "${distro}" == "alpine" ]]; then
        ln -sv "${script_dirs}/gitignore" ~/.config/git/ignore
    elif is_valid_distro "${distro}"; then
        ln -siv "${script_dir}/gitignore" ~/.config/git/ignore
    fi
    echo "[INFO] >>> Done"
    echo ""

    if [[ "${no_install}" == false ]]; then
      dotfiles::install_diff_highlight
    fi
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  if [[ "--help" == "$1" || "-h" == "$1" ]]; then
    echo "Usage: $0 [--no-install]"
    echo "  --no-install  Skip the installation of diff-highlight"
    exit 0
  fi
  check_os
  dotfiles::setup_git
fi
