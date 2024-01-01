colorscheme molokai

" === rainbow ===
" let g:rainbow_active = 1

" === gitgutter ===
" highlight GitGutterDelete guifg=#EB0A13 ctermfg=1
" highlight GitGutterAdd    guifg=#AEC90B ctermfg=2
" highlight GitGutterChange guifg=#FB8505 ctermfg=3

" === vim-polyglot ===
" let g:cpp_member_highlight = 1
" let g:cpp_simple_highlight = 1

" === vim-cpp-enhanced-highlight ===
" let g:cpp_class_scope_highlight = 1

" === coc.nvim ===
" <Tab>で候補を選択する関数
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

"explorer.icon.enableNerdFont"
lua << END
-- === nvim-tree ===
-- require'nvim-tree'.setup()

-- === lualine ===
require'lualine'.setup {
  options = { theme = 'carbonfox' },
  tabline = { lualine_a = {'buffers'} }
}

-- === mini.indentscope ===
-- require'mini.indentscope'.setup {
--   symbol = '▏'
-- }
END
