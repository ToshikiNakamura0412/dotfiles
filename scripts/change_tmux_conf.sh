#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
VALID_TMUX_POWER_THEME=("default" "gold" "everforest" "moon" "coral" "snow" "forest" "violet" "redwine")

function show_usage() {
    echo ""
    echo "Usage: $0 <prefix_key> <tmux_power_theme>"
    echo ""
    echo "    <prefix_key> : tmux prefix key (e.g. C-s, C-a)"
    echo "    <tmux_power_theme> : theme name of tmux-power"
    for theme in ${VALID_TMUX_POWER_THEME[@]}; do
        echo "        - $theme"
    done
}

function check_valid_tmux_power_theme() {
    local tmux_power_theme=$1
    for theme in ${VALID_TMUX_POWER_THEME[@]}; do
        if [[ $tmux_power_theme == $theme ]]; then
            return 0
        fi
    done
    return 1
}

function change_tmux_conf() {
    local prefix_key=$1
    local tmux_power_theme=$2

    if ! check_valid_tmux_power_theme $tmux_power_theme; then
        echo "Error: invalid tmux power theme"
        show_usage
        exit 1
    fi

    echo "prefix key: $prefix_key"
    echo "tmux power theme: $tmux_power_theme"

    if [[ ! -e $HOME/.tmux.conf ]]; then
        ln -sfv $SCRIPT_DIR/../tmux.conf ~/.tmux.conf
    fi
    if [[ -e ../tmux.conf.bak ]]; then
        cp ../tmux.conf.bak ../tmux.conf
    fi
    sed -i.bak "s/set -g prefix C-s/set -g prefix $prefix_key/g" $(readlink -f $HOME/.tmux.conf)
    sed -i "s/set -g @tmux_power_theme 'moon'/set -g @tmux_power_theme '$tmux_power_theme'/g" $(readlink -f $HOME/.tmux.conf)
}

function main() {
    if [[ $1 == "-h" ]] || [[ $# -ne 2 ]]; then
        show_usage
        exit 0
    fi

    change_tmux_conf $1 $2
}

main $@
