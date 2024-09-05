#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
source $SCRIPT_DIR/common.bash

function setup_bash() {
    echo ""
    echo "setting bash... "
    if [[ -e ~/.bashrc ]]; then
        source ~/.bashrc
    fi
    if ! type __git_ps1 &> /dev/null; then
        curl -fLo ~/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
        curl -fLo ~/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

        local target_strings=(
            "source ~/git-prompt.sh"
            "source ~/git-completion.bash"
        )
        delete_lines ~/.bashrc "${target_strings[@]}"
        add_lines ~/.bashrc "${target_strings[@]}"
    fi
    if [[ ! -e ~/.bash_profile ]]; then
        ln -sfv ~/.bashrc ~/.bash_profile
    fi
    echo ">>> Done"
    echo ""
}

function setup_zsh() {
    echo ""
    echo "setting zsh... "
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ln -sfv $SCRIPT_DIR/../zsh/zshrc ~/.zshrc
    ln -sfv $SCRIPT_DIR/../zsh/p10k.zsh ~/.p10k.zsh
    ~/.fzf/install
    echo ">>> Done"
    echo ""
}

function setup_shell() {
    echo "setting shell... "
    if [ -d ~/.config/dotfiles ]; then
        rm -rf ~/.config/dotfiles
    fi
    if [ ! -d ~/.config/dotfiles ]; then
        mkdir -pv ~/.config/dotfiles
    fi
    ln -sfv $SCRIPT_DIR/common.bash ~/.config/dotfiles/common.bash
    ln -sfv $SCRIPT_DIR/my_conf.bash ~/.config/dotfiles/my_conf.bash

    local target_strings=(
        "# dotfiles",
        "source ~/.config/dotfiles/my_conf.bash"
    )
    if [ -e ~/.bashrc ]; then
        delete_lines ~/.bashrc "${target_strings[@]}"
        add_lines ~/.bashrc "${target_strings[@]}"
    fi
    if [ -e ~/.zshrc ]; then
        delete_lines ~/.zshrc "${target_strings[@]}"
        add_lines ~/.zshrc "${target_strings[@]}"
    fi
    echo "Done"
    echo ""
}

function main() {
    check_os
    local distro=$(get_distro)
    if is_valid_distro ${distro}; then
        setup_bash
        setup_zsh
    fi
    setup_shell
}

main
