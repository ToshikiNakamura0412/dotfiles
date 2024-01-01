# dotfiles
Setting for git, aliases, neovim and tmux
## Environment
- Ubuntu
- WSL2
- bash or zsh
## Prerequisites
Following software should be installed
- `neovim`
- `tmux`
## Installation
```
git clone https://github.com/ToshikiNakamura0412/dotfiles.git ~/dotfiles
~/dotfiles/setup.sh

# bash
source ~/.bashrc
# zsh
source ~/.zshrc
```
### Setup plugin
Please set executable.command path for `jedi-language-server`
```
nvim ~/.config/nvim/coc-settings.json
```
### zsh
If you use oh-my-zsh (powerlevel10k theme), you should set the following parameter in `~/.p10k.zsh`
- `typeset -g POWERLEVEL9K_INSTANT_PROMPT=off`
### Upgrade (or Install) NeoVim
```
git clone --depth=1 https://github.com/ToshikiNakamura0412/my_ubuntu_setup.git ~/my_ubuntu_setup
~/my_ubuntu_setup/scripts/upgrade_vim.sh
~/my_ubuntu_setup/scripts/upgrade_nvim.sh
```
## Vim plugin manager
vim-plug (https://github.com/junegunn/vim-plug.git)
## tmux plugin manager
tpm (https://github.com/tmux-plugins/tpm.git)
## C/C++ Completion for ROS
If you want to enable C/C++ completion for ROS, the following commands must be executed when building packages.
```
# build and enable completion for all packages
cd <ROS workspace>
catkin-compile-commands-json

# build and enable completion for one package
cd <target package>
catkin-compile-commands-json-this
```
