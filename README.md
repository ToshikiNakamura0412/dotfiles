# dotfiles

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

![image](https://github.com/ToshikiNakamura0412/dotfiles/wiki/images/dotfiles.png)

- Setting for aliases, shell, zsh, git, vim, neovim and tmux
  - tmux
    - prefix key: `Ctrl-s`
    - If you want to change the prefix key and the theme, please refer to [Setup](#setup)
- This repository contains the following submodules:
  - [vim](https://github.com/ToshikiNakamura0412/vim.git)
  - [nvim](https://github.com/ToshikiNakamura0412/nvim.git)
- This repository is used in [dockerfiles](https://github.com/ToshikiNakamura0412/dockerfiles.git)

## Environment
### OS
- Linux
  - alpine
  - arch
  - centos (stream)
  - debian
  - fedora
  - opensuse (leap)
  - ubuntu
- macOS (Prerequisites: Homebrew, pip3)

### Architecture
- x86_64
- arm64

### Shell
- bash
- zsh

## Installation
- If you want to setup only without installing prerequisites, please use `--setup-only` option.
  - Prerequisites: curl
```bash
git clone --recursive https://github.com/ToshikiNakamura0412/dotfiles.git
./dotfiles/install.bash [--setup-only]
```

## Setup
### zsh
If you want to change the terminal appearance, please execute the following:
```bash
p10k configure
```

### tmux
If you want to change the prefix key and the theme, please execute the following:
```bash
cd dotfiles/scripts/
./setup_tmux.bash <prefix_key> <tmux_power_theme> [with_setup (optional)]
```
Show the help:
```bash
./setup_tmux.bash -h
```

### plugin
#### nvim
- If you want to enable Github Copilot, please execute the following in Neovim:
  ```
  :Copilot setup
  ```

## Update
```bash
cd ~/dotfiles
git pull
git submodule update --remote --recursive
```

## Usage
### zsh
| Command | Description |
| --- | --- |
| `Ctrl-r` | Open fzf |

### tmux
| Command | Description |
| --- | --- |
| `<prefix_key> + [` | Copy mode (`y`: yank) |

- [pain control](https://github.com/tmux-plugins/tmux-pain-control.git)

### Neovim
| Command | Description |
| --- | --- |
| `Ctrl-e` | Open file explorer |
| `ff` | Open fzf |

#### C/C++ Completion for ROS1
If you want to enable C/C++ completion for ROS1, please execute the following:
```bash
# enable simple completion
# - add following paths
#   - /opt/ros/<ROS DISTRO>/include
#   - <target package>/include
roscd <target package>
create_simple_compile_flags

# build and enable completion of target package
roscd <target package>
cbt

# build and enable completion of all packages
cb
```

## Troubleshooting
### Character encoding issue
Set your terminal font as `Hack Nerd Font`.

### The text color is white
It may not be compatible with True Color.<br>
If you have color settings in your shell, please disable them.<br>
If the issue persists, please execute the following:
```bash
export TERM=screen-256color
```

### It's not working properly
Please reinstall.
