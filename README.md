# dotfiles
Setting for aliases, vim, neovim and tmux
## Environment
- Ubuntu
- bash or zsh
- (For mac)
  - branch: `mac`
## Prerequisites
Following software should be installed
- `vim`
- `neovim`
- `tmux`
## Installation
```
git clone --depth=1 https://github.com/ToshikiNakamura0412/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
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
## Update
```
cd ~/dotfiles
./update.sh
# bash
source ~/.bashrc
# zsh
source ~/.zshrc
```
### Upgrade (or Install) Vim/NeoVim
```
git clone --depth=1 https://github.com/ToshikiNakamura0412/my_ubuntu_setup.git ~/my_ubuntu_setup
cd ~/my_ubuntu_setup/scripts
./upgrade_vim.sh
./upgrade_nvim.sh
```
## Vim plugin manager
vim-plug (https://github.com/junegunn/vim-plug.git)
