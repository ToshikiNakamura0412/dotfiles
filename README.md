# dotfiles
Setting for git, aliases, neovim and tmux
## Environment
- Ubuntu
- WSL2
- bash or zsh
## Setting file
- Neovim
- tmux
## Installation
```
git clone --recursive https://github.com/ToshikiNakamura0412/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```
### Setup plugin
Please set executable.command path for `jedi-language-server`
```
nvim ~/.config/nvim/coc-settings.json
```
### zsh
If you use oh-my-zsh (powerlevel10k theme), you should set the following parameter in `~/.p10k.zsh`
- `typeset -g POWERLEVEL9K_INSTANT_PROMPT=off`
### Upgrade Git
```
~/dotfiles/scripts/upgrade_git.sh
```
## Vim plugin manager
vim-plug (https://github.com/junegunn/vim-plug.git)
## tmux plugin manager
tpm (https://github.com/tmux-plugins/tpm.git)

prefix key: `Ctrl-s`
## C/C++ Completion for ROS
If you want to enable C/C++ completion for ROS, the following commands must be executed when building packages.
```
# enable simple completion
# - add following paths
#   - /opt/ros/<ROS DISTRO>/include
#   - <target package>/include
cd <target package>
create-simple-compile-flags

# build and enable completion related to target package
cd <target package>
cbt-export-compile-commands
```
