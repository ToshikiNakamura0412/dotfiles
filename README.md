# dotfiles
Setting for aliases, tmux, vim and neovim
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
for bash
```
curl -sL install-node.vercel.app/lts | sudo bash
```
for zsh
```
curl -sL install-node.vercel.app/lts | sudo zsh
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
