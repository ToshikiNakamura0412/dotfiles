# dotfiles
- Setting for aliases, git, neovim and tmux
- tmux
  - prefix key: `Ctrl-s`
## Environment
- Ubuntu
- WSL2
- bash or zsh
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
### [Option] Upgrade Git
```
~/dotfiles/scripts/upgrade_git.sh
```
## Update
```
cd ~/dotfiles
git pull
git submodule update
```
## C/C++ Completion for ROS
If you want to enable C/C++ completion for ROS1, please execute the following:
```
# enable simple completion
# - add following paths
#   - /opt/ros/<ROS DISTRO>/include
#   - <target package>/include
cd <target package>
create_simple_compile_flags

# build and enable completion related to target package
cd <target package>
cbt_export_compile_commands
```
## "Troubleshooting Tips
### Character encoding issue
Set your terminal font as `Hack Nerd Font`.
### The text color is white
It may not be compatible with True Color.<br>
If you have color settings in your shell, please disable them.<br>
If the issue persists, please execute the following:
```
export TERM=screen-256color
```
### It's not working properly
Please reinstall.
