colorscheme molokai

" === rainbow ===
let g:rainbow_active = 1

" === gitgutter ===
highlight GitGutterDelete guifg=#EB0A13 ctermfg=1
highlight GitGutterAdd    guifg=#AEC90B ctermfg=2
highlight GitGutterChange guifg=#FB8505 ctermfg=3

" === vim-polyglot ===
let g:cpp_member_highlight = 1
let g:cpp_simple_highlight = 1

" === vim-cpp-enhanced-highlight ===
let g:cpp_class_scope_highlight = 1

" === coc.nvim ===
" Select a candidate for completion by Tab
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

lua << END
-- === lualine ===
require'lualine'.setup {
  options = { theme = 'carbonfox' },
  tabline = { lualine_a = {'buffers'} }
}

-- === mini.indentscope ===
require'mini.indentscope'.setup {
  symbol = '▏'
}
END
