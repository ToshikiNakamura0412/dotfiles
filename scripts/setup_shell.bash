#!/bin/bash

DOTFILES_SETUP_SHELL_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${DOTFILES_SETUP_SHELL_SCRIPT_DIR}/common.bash"

DOTFILES_CONFIG_DIR=~/.config/dotfiles

dotfiles::create_dotfiles_dir() {
  local config_dir="${DOTFILES_CONFIG_DIR}"

  if [ -d "${config_dir}" ]; then
    rm -rf "${config_dir}"
  fi
  if [ ! -d "${config_dir}" ]; then
    mkdir -pv "${config_dir}"
  fi
}

dotfiles::setup_bash() {
  local config_dir="${DOTFILES_CONFIG_DIR}"

  echo ""
  echo "[INFO] setting bash... "
  if [[ -e ~/.bashrc ]]; then
    source ~/.bashrc
  fi
  if ! type __git_ps1 &> /dev/null; then
    curl -fLo "${config_dir}/git-prompt.sh" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
    curl -fLo "${config_dir}/git-completion.bash" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

    local target_strings=(
      "source ${DOTFILES_CONFIG_DIR}/git-prompt.sh"
      "source ${DOTFILES_CONFIG_DIR}/git-completion.bash"
    )
    delete_lines ~/.bashrc "${target_strings[@]}"
    add_lines ~/.bashrc "${target_strings[@]}"
  fi
  if [[ ! -e ~/.bash_profile ]]; then
    ln -sfv ~/.bashrc ~/.bash_profile
  fi
  echo "[INFO] >>> Done"
  echo ""
}

dotfiles::setup_zsh() {
  local script_dir="${DOTFILES_SETUP_SHELL_SCRIPT_DIR}"

  echo ""
  echo "[INFO] setting zsh... "
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  if [[ -e ~/.zshrc ]]; then
    mv -v ~/.zshrc ~/.zshrc.bak
  fi
  cp -fv "${script_dir}/../zsh/zshrc" ~/.zshrc
  ln -sfv "${script_dir}/../zsh/p10k.zsh" ~/.p10k.zsh
  ~/.fzf/install
  echo "[INFO] >>> Done"
  echo ""
}

dotfiles::setup_shell() {
  local script_dir="${DOTFILES_SETUP_SHELL_SCRIPT_DIR}"
  local config_dir="${DOTFILES_CONFIG_DIR}"

  echo ""
  echo "[INFO] setting shell... "
  ln -sfv "${script_dir}/common.bash" "${config_dir}/common.bash"
  ln -sfv "${script_dir}/my_conf.bash" "${config_dir}/my_conf.bash"

  local target_strings=(
    "# dotfiles"
    "source ${config_dir}/my_conf.bash"
  )
  if [ -e ~/.bashrc ]; then
    delete_lines ~/.bashrc "${target_strings[@]}"
    add_lines ~/.bashrc "${target_strings[@]}"
  fi
  if [ -e ~/.zshrc ]; then
    delete_lines ~/.zshrc "${target_strings[@]}"
    add_lines ~/.zshrc "${target_strings[@]}"
  fi
  echo "[INFO] >>> Done"
  echo ""
}

dotfiles::setup_shell_main() {
    check_os
    dotfiles::create_dotfiles_dir
    local distro="$(get_distro)"
    if is_valid_distro "${distro}"; then
        dotfiles::setup_bash
        dotfiles::setup_zsh
    fi
    dotfiles::setup_shell
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  dotfiles::setup_shell_main
fi
