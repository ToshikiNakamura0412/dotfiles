" Automatic vim-plug installation
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Run :PlugInstall if any plugins are missing
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" List of plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'tomasr/molokai'
Plug 'EdenEast/nightfox.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'machakann/vim-highlightedyank'
Plug 'sentriz/vim-print-debug'
Plug 'tpope/vim-commentary'
Plug 'kylechui/nvim-surround'
Plug 'lewis6991/gitsigns.nvim'
Plug 'NeogitOrg/neogit'
Plug 'sindrets/diffview.nvim'
Plug 'skanehira/translate.vim'
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'echasnovski/mini.indentscope'
Plug 'sheerun/vim-polyglot'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
call plug#end()
let g:coc_global_extensions = [
    \'coc-lists',
    \'coc-pairs',
    \'coc-snippets',
    \'coc-sh',
    \'coc-cmake',
    \'coc-jedi',
    \'coc-yaml',
    \'coc-vimlsp',
    \]
