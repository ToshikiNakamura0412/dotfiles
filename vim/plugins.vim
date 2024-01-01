" vim-plugがなかったらインストール
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" 足りないプラグインがあれば :PlugInstall を実行
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" プラグイン一覧
call plug#begin('~/.local/share/nvim/plugged')
Plug 'tomasr/molokai'
Plug 'skanehira/translate.vim'
Plug 'jiangmiao/auto-pairs' 
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-commentary'
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'echasnovski/mini.indentscope'
Plug 'sheerun/vim-polyglot'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'airblade/vim-gitgutter'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

Plug 'EdenEast/nightfox.nvim'
call plug#end()

" molokai
" colorscheme molokai
" colorscheme nightfox
colorscheme carbonfox
" rainbow
let g:rainbow_active = 1
" gitgutter
highlight GitGutterDelete guifg=#EB0A13 ctermfg=1
highlight GitGutterAdd    guifg=#AEC90B ctermfg=2
highlight GitGutterChange guifg=#FB8505 ctermfg=3
" vim-polyglot
let g:cpp_member_highlight = 1
let g:cpp_simple_highlight = 1
" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
" nvim-tree
nnoremap <silent><C-e> :NvimTreeOpen<CR>

" coc.nvim
" (Vim, Yaml, Bash, Json, Python, CMake)
let g:coc_global_extensions = ['coc-vimlsp', 'coc-yaml', 'coc-sh', 'coc-json', 'coc-jedi', 'coc-cmake', 'coc-snippets']
" <Tab>で候補を選択する関数
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
" 補完表示時のEnterで改行をしない
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : '\<CR>'
" 補完候補の選択をTab/Shitf-Tabで変更
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1):
  \ <SID>check_back_space() ? '\<Tab>' :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : '\<S-TAB>' ' '\<C-h>'
nnoremap <silent> H :<C-u>call CocAction('doHover') <cr>
nmap <silent> df <Plug>(coc-definition)
nmap <silent> rf <Plug>(coc-references)
nmap <silent> rn <Plug>(coc-rename)
nmap <silent> fmt <Plug>(coc-format)
nmap <silent> mne <Plug>(coc-diagnostic-next-error)
nmap <silent> mpe <Plug>(coc-diagnostic-prev-error)


lua << END
require'nvim-tree'.setup()
require'lualine'.setup {
  --options = { theme = 'codedark' },
  --options = { theme = 'nightfox' },
  options = { theme = 'carbonfox' }, 
  tabline = { lualine_a = {'buffers'} }
}
require'mini.indentscope'.setup {
  symbol = '▏'
}
END
