" === Look ===
set number
set cursorline
set colorcolumn=121
highlight ColorColumn guibg=gray ctermbg=gray
set termguicolors

" === control ===
" バッファが編集中でもその他のファイルを開けるように
set hidden
" スクロール時の余裕
set scrolloff=20
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" 行をまたいで移動
set whichwrap=b,s,h,l,<,>,[,],~

" === edit ===
" Copy to clipboard
set clipboard=unnamedplus
" 保存時に行末の空白を削除する
autocmd BufWritePre * :%s/\s\+$//ge
" 最後にカーソルがあった場所に移動
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END
" undo
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

" === Tab ===
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 空白部分でtabキーやbackspaceを押したときにカーソル移動する幅
set softtabstop=4
" 自動インデントの幅
set shiftwidth=4
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" 改行時に前の行のインデントを継続する
set autoindent " :set pasteで解除可能

" === search ===
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
