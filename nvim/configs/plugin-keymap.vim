" === nvim-tree ===
nnoremap <silent><C-e> :CocCommand explorer<CR>

" === coc ===
" No line break on Enter in completion candidate display
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : '<CR>'
" Select a candidate for completion by Tab/Shift-Tab
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB>  coc#pum#visible() ? coc#pum#next(1): <SID>check_back_space() ? '<Tab>'  : coc#refresh()
inoremap <silent><expr> <Down> coc#pum#visible() ? coc#pum#next(1): <SID>check_back_space() ? '<Down>' : coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : '<C-h>'
inoremap <expr><Up>    coc#pum#visible() ? coc#pum#prev(1) : '<C-h>'
" Others
nnoremap <silent> H : <C-u>call CocAction('doHover') <cr>
nnoremap <silent> df  <Plug>(coc-definition)
nnoremap <silent> rf  <Plug>(coc-references)
nnoremap <silent> rn  <Plug>(coc-rename)
nnoremap <silent> fmt <Plug>(coc-format)
nnoremap <silent> mne <Plug>(coc-diagnostic-next-error)
nnoremap <silent> mpe <Plug>(coc-diagnostic-prev-error)
