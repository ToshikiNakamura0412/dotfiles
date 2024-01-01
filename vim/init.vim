" === 表示系 ===
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 121列目を強調
set colorcolumn=121
highlight ColorColumn guibg=gray ctermbg=gray
" True color
set termguicolors

" === 操作系 ===
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" バッファが編集中でもその他のファイルを開けるように
set hidden
" スクロール時の余裕
set scrolloff=20
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" 行をまたいで移動
set whichwrap=b,s,h,l,<,>,[,],~
" [Normal] 右のタブに移動
noremap <C-n> :bnext<CR>
" [Normal] 左のタブに移動
noremap <C-p> :bprevious<CR>
" [Insert] jjをESCとして扱う
inoremap jj <Esc>
" [Insert] 行途中で次の行に新規挿入
inoremap <C-o> <C-o>o
" [Insert] カーソルを右に移動
inoremap <C-f> <Right>
" [Insert] カーソルを左に移動
inoremap <C-b> <Left>
" [Normal] 行頭にカーソル移動
noremap <Space>h ^
" [Normal] 行末にカーソル移動
noremap <Space>l $

" === 編集系 ===
" ヤンクでクリップボードにコピー
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

" === Tab系 ===
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

" === 検索系 ===
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase



" 外部ファイルの読み込み
source ~/.config/nvim/plugins.vim
