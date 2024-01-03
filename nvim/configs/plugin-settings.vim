colorscheme molokai

" === rainbow ===
let g:rainbow_active = 1

" === vim-polyglot ===
let g:cpp_member_highlight = 1
let g:cpp_simple_highlight = 1

" === vim-cpp-enhanced-highlight ===
let g:cpp_class_scope_highlight = 1

" === gitgutter ===
highlight GitGutterDelete guifg=#EB0A13 ctermfg=1
highlight GitGutterAdd    guifg=#AEC90B ctermfg=2
highlight GitGutterChange guifg=#FB8505 ctermfg=3

lua << END
-- === lualine ===
require'lualine'.setup { options = { theme = 'carbonfox' } }

--- === nvim-tree ===
require'nvim-tree'.setup {  }

--- === nvim-surround ===
require'nvim-surround'.setup {  }

-- === mini.indentscope ===
require'mini.indentscope'.setup { symbol = '▏' }

-- === toggleterm ===
require'toggleterm'.setup {  }
END
