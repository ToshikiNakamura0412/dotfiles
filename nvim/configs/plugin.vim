" Automatic vim-plug installation
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'skanehira/translate.vim'
Plug 'tpope/vim-commentary'
Plug 'ryanoasis/vim-devicons'
" Plug 'luochen1990/rainbow'
" Plug 'Yggdroot/indentLine'
" Plug 'echasnovski/mini.indentscope'
" Plug 'sheerun/vim-polyglot'
" Plug 'octol/vim-cpp-enhanced-highlight'
call plug#end()
let g:coc_global_extensions = [
    \'coc-pairs',
    \'coc-vimlsp',
    \'coc-yaml',
    \'coc-sh',
    \'coc-json',
    \'coc-jedi',
    \'coc-cmake',
    \'coc-snippets',
    \'coc-yank',
    \'coc-webview',
    \'coc-markdown-preview-enhanced',
    \'coc-git',
    \'coc-lists',
    \'coc-explorer'
    \]
