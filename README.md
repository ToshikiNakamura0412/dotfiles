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
```
### zsh
If you use oh-my-zsh (powerlevel10k theme), you should define the following parameter (L1654 in `~/.p10k.zsh`):
- `typeset -g POWERLEVEL9K_INSTANT_PROMPT=off`
## Vim plugin manager
vim-plug (https://github.com/junegunn/vim-plug.git)
### Setup coc
```
sudo apt install nodejs npm
sudo npm install -g n
sudo n stable
```
### Setup coc extensions
```
# C/C++
pip3 install --upgrade neovim
sudo apt install clangd
# Python
pip3 install jedi-language-server
```
Please set executable.command path for `jedi-language-server`
```
nvim ~/.config/nvim/coc-settings.json
```
### Upgrade Vim/NeoVim
```
sudo add-apt-repository ppa:jonathonf/vim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt upgrade
```
