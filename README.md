# dotfiles
Setting for aliases, tmux, vim and neovim
## Environment
- Unix or Linux
- bash or zsh
## Prerequisites
- `tmux` should be installed
- `vim` should be installed
- `neovim` should be installed
## Installation
```
git clone --depth=1 https://github.com/ToshikiNakamura0412/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```
### zsh
If you use oh-my-zsh (powerlevel10k theme), you should define the following parameter (L1635 in `~/.p10k.zsh`):
- `typeset -g POWERLEVEL9K_INSTANT_PROMPT=off`
## Vim plugin manager
vim-plug (https://github.com/junegunn/vim-plug.git)
