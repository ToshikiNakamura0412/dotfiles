#!/bin/bash

DOTFILES_INSTALL_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DOTFILES_SETUP_ONLY=false
if [[ "--setup-only" == "$1" ]]; then
  DOTFILES_SETUP_ONLY=true
fi

dotfiles::install_prerequisites() {
  local script_dir="${DOTFILES_INSTALL_SCRIPT_DIR}"

  echo ""
  echo "[INFO] ======================="
  echo "[INFO]  install prerequisites"
  echo "[INFO] ======================="
  echo ""
  "${script_dir}/scripts/install_prerequisites.bash"
}

dotfiles::setup() {
  local script_dir="${DOTFILES_INSTALL_SCRIPT_DIR}"
  local setup_only="${DOTFILES_SETUP_ONLY}"

  echo ""
  echo "[INFO] ======="
  echo "[INFO]  setup"
  echo "[INFO] ======="
  echo ""
  "${script_dir}/scripts/setup_shell.bash"
  "${script_dir}/scripts/setup_tmux.bash"

  if [[ "${setup_only}" == true ]]; then
    "${script_dir}/scripts/setup_git.bash" --no-install
    source "${script_dir}/nvim/configs/basic/install.sh"
    vim_setup
  else
    "${script_dir}/scripts/setup_git.bash"
    "${script_dir}/nvim/scripts/setup_nvim.sh"
    if [[ -e "$HOME/.local/bin/nvim" ]]; then
      ln -sfv $HOME/.local/bin/nvim $HOME/.local/bin/vim
    fi
  fi
}

dotfiles::install_main() {
  local setup_only="${DOTFILES_SETUP_ONLY}"

  if [[ "${setup_only}" == false ]]; then
    dotfiles::install_prerequisites
  fi
  dotfiles::setup
  echo ""
  echo "[INFO] please set your terminal font as 'Hack Nerd Font Regular'"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  if [[ "--help" == "$1" || "-h" == "$1" ]]; then
    echo "Usage: $0 [--setup-only]"
    echo "  --setup-only: Only run the setup scripts without installing prerequisites."
    exit 0
  fi
  dotfiles::install_main
fi
