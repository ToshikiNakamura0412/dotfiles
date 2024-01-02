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
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'skanehira/translate.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'echasnovski/mini.indentscope'
Plug 'sheerun/vim-polyglot'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
let g:coc_global_extensions = [
    \'coc-lists',
    \'coc-yank',
    \'coc-pairs',
    \'coc-explorer',
    \'coc-webview',
    \'coc-markdown-preview-enhanced',
    \'coc-snippets',
    \'coc-sh',
    \'coc-cmake',
    \'coc-jedi',
    \'coc-json',
    \'coc-yaml',
    \'coc-vimlsp',
    \]
