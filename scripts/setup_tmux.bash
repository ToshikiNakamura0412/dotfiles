#!/bin/bash

DOTFILES_SETUP_TMUX_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_VALID_TMUX_POWER_THEME=(
  "default"
  "gold"
  "everforest"
  "moon"
  "coral"
  "snow"
  "forest"
  "violet"
  "redwine"
)

dotfiles::show_usage() {
  local valid_tmux_power_theme=("${DOTFILES_VALID_TMUX_POWER_THEME[@]}")

  echo ""
  echo "[INFO] Usage:"
  echo "[INFO]     Setup tmux:"
  echo "[INFO]         $0"
  echo ""
  echo "[INFO]     Change tmux prefix key and tmux-power theme:"
  echo "[INFO]         $0 <prefix_key> <tmux_power_theme> [with_setup]"
  echo ""
  echo "[INFO]         <prefix_key> : tmux prefix key (e.g. C-s, C-a)"
  echo "[INFO]         <tmux_power_theme> : theme name of tmux-power"
  for theme in "${valid_tmux_power_theme[@]}"; do
    echo "[INFO]             - $theme"
  done
  echo "[INFO]         [with_setup] : setup tmux (optional)"
}

dotfiles::setup_tmux() {
  local script_dir="${DOTFILES_SETUP_TMUX_SCRIPT_DIR}"

  echo ""
  echo "[INFO] setting tmux... "
  if [ -d ~/.tmux ]; then
    rm -rf ~/.tmux
  fi
  ln -sfv "${script_dir}/../tmux.conf" ~/.tmux.conf
  git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/bin/install_plugins
  echo "[INFO] >>> Done"
  echo ""
}

dotfiles::is_valid_tmux_power_theme() {
  local tmux_power_theme=$1
  local valid_tmux_power_theme=("${DOTFILES_VALID_TMUX_POWER_THEME[@]}")

  for theme in "${valid_tmux_power_theme[@]}"; do
    if [[ "${tmux_power_theme}" == "${theme}" ]]; then
      return 0
    fi
  done
  return 1
}

dotfiles::change_tmux_conf() {
    local prefix_key=$1
    local tmux_power_theme=$2
    local script_dir="${DOTFILES_SETUP_TMUX_SCRIPT_DIR}"

    if ! dotfiles::is_valid_tmux_power_theme "${tmux_power_theme}"; then
        echo "[ERROR] Invalid tmux power theme"
        dotfiles::show_usage
        exit 1
    fi

    echo "[INFO] changing tmux conf... "
    echo "[INFO] prefix key: ${prefix_key}"
    echo "[INFO] tmux power theme: ${tmux_power_theme}"

    if [[ ! -e ~/.tmux.conf ]]; then
        ln -sfv "${script_dir}/../tmux.conf" ~/.tmux.conf
    fi
    if [[ -e ../tmux.conf.bak ]]; then
        cp ../tmux.conf.bak ../tmux.conf
    fi
    sed -i.bak "s/set -g prefix C-s/set -g prefix $prefix_key/g" $(readlink -f ~/.tmux.conf)
    sed -i "s/set -g @tmux_power_theme 'moon'/set -g @tmux_power_theme '$tmux_power_theme'/g" $(readlink -f ~/.tmux.conf)
    echo "[INFO] >>> Done"
}

dotfiles::setup_tmux_main() {
    if [[ $1 == "-h" ]] || [[ $1 == "--help" ]]; then
        dotfiles::show_usage
        exit 0
    fi
    if [[ $# -ge 2 ]]; then
        dotfiles::change_tmux_conf $1 $2
    fi
    if [[ $# -eq 0 ]] || [[ $3 == "with_setup" ]]; then
        dotfiles::setup_tmux
    fi
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  dotfiles::setup_tmux_main $@
fi
