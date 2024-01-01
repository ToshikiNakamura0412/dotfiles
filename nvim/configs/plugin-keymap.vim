" === nvim-tree ===
nnoremap <silent><C-e> :CocCommand explorer<CR>

" === coc ===
" No line break on Enter in completion candidate display
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : '\<CR>'
" Select a candidate for completion by Tab/Shift-Tab
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1):
  \ <SID>check_back_space() ? '\<Tab>' :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : '\<S-TAB>' ' '\<C-h>'
" Others
nnoremap <silent> H :<C-u>call CocAction('doHover') <cr>
nmap <silent> df <Plug>(coc-definition)
nmap <silent> rf <Plug>(coc-references)
nmap <silent> rn <Plug>(coc-rename)
nmap <silent> fmt <Plug>(coc-format)
nmap <silent> mne <Plug>(coc-diagnostic-next-error)
nmap <silent> mpe <Plug>(coc-diagnostic-prev-error)
