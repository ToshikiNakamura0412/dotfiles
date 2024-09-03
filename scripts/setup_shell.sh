#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
if [ "$(uname)" = "Linux" ]; then
    source /etc/os-release
    OS_NAME=$(echo $ID)
elif [ "$(uname)" = "Darwin" ]; then
    OS_NAME="mac"
else
    echo "This OS is not supported."
    exit 1
fi

if [ $OS_NAME = "ubuntu" ] || [ $OS_NAME = "debian" ] || [ $OS_NAME = "alpine" ] || [ $OS_NAME = "mac" ]; then
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

    echo ""
    echo "setting bash... "
    if ! type __git_ps1 &> /dev/null; then
        curl -fLo ~/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
        curl -fLo ~/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
        echo "source ~/git-prompt.sh" >> ~/.bashrc
        echo "source ~/git-completion.bash" >> ~/.bashrc
    fi
    echo ">>> Done"
    echo ""
fi

echo -n "setting shell... "
if [ -e ~/.bashrc ]; then # bashrc
    LOAD_COMMAND_COUNT=$(cat ~/.bashrc | grep dotfiles\/scripts\/my_conf\.sh | wc -l)
    if [ $LOAD_COMMAND_COUNT -eq 0 ]; then
        echo "" >> ~/.bashrc
        echo "# dotfiles" >> ~/.bashrc
        echo "source $SCRIPT_DIR/my_conf.sh" >> ~/.bashrc
    fi
fi
if [ -e ~/.zshrc ]; then # zshrc
    LOAD_COMMAND_COUNT=$(cat ~/.zshrc | grep dotfiles\/scripts\/my_conf\.sh | wc -l)
    if [ $LOAD_COMMAND_COUNT -eq 0 ]; then
        echo "" >> ~/.zshrc
        echo "# dotfiles" >> ~/.zshrc
        echo "source $SCRIPT_DIR/my_conf.sh" >> ~/.zshrc
    fi
fi
echo "Done"
echo ""
