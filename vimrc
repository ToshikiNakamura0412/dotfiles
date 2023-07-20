" ===  プラグイン ===
" vim-plugがなかったらインストール
if empty(glob('~/.vim/autoload/plug.vim'))
      silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" 足りないプラグインがあれば :PlugInstall を実行
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
" プラグイン一覧
call plug#begin('~/.vim/plugged')
Plug 'tomasr/molokai'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'skanehira/translate.vim'
Plug 'junegunn/fzf'
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-highlightedyank'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'previm/previm'

" 自動補完プラグイン
" 必須
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
" 任意
Plug 'Shougo/neco-vim' " Vim
call plug#end()
" coc.nvim 拡張機能(Bash, Python, CMake, C/C++/Objective-C, Json)
let g:coc_global_extensions = ['coc-sh', 'coc-jedi', 'coc-cmake', 'coc-clangd', 'coc-json']


" === 基本設定系 ===
" 文字コードをUFT-8に設定
set encoding=utf-8
set modifiable
set write
set fenc=utf-8
scriptencoding
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" ファイルを上書きする前にバックアップを作ることを無効化
set nowritebackup
" マウス操作有効化
set mouse=a


" === 表示系 ===
" カラースキーマ
colorscheme molokai
" 行番号を表示
set number
" タイトルを表示
set title
" 現在の行を強調表示
set cursorline
" 120列目を強調
set colorcolumn=120
highlight ColorColumn guibg=#202020 ctermbg=lightgray
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" エラーメッセージの表示時にビープを鳴らさない
set noerrorbells
" 対応する括弧やブレースを表示
set showmatch matchtime=1
" シンタックスハイライト
syntax on
" スクロール時の余裕
set scrolloff=20
" 最後にカーソルがあった場所に移動
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END
" menuone: 補完候補が一つしかなくてもポップアップメニューを表示
set completeopt=menuone,noinsert
" 補完表示時のEnterで改行をしない
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"
" 補完候補の選択をTab/Shitf-Tabで変更
inoremap <expr><Tab>  pumvisible() ? "<C-n>" : "<Tab>"
inoremap <expr><S-Tab>  pumvisible() ? "<C-p>" : "<S-Tab>"
" ポップアップメニューの最大高さ
set pumheight=10
" シンタックスハイライト
set termguicolors


" ===  操作系 ===
" [Insertモード] jjをESCとして扱う
inoremap jj <Esc>
" [Insertモード] 行途中で次の行に新規挿入
inoremap <C-o> <C-o>o
" [Normal] ;でコマンド入力
noremap ; :
" 行をまたいで移動
set whichwrap=b,s,h,l,<,>,[,],~
" [Normal] 行頭にカーソル移動
noremap <Space>h ^
noremap <Space><Left> ^
" [Normal] 行末にカーソル移動
noremap <Space>l $
noremap <Space><Right> $
" [Normal] ページスクロール(上)
noremap <C-Up> <C-u>
" [Normal] ページスクロール(下)
noremap <C-Down> <C-d>
" [Normal] 新規タブを開く
noremap <C-t> :enew<CR>
" [Normal] 左のタブに移動
noremap <C-p> :bprevious<CR>
" [Normal] 右のタブに移動
noremap <C-n> :bnext<CR>
" [Normal] w!! でsudoで保存可
cmap w!! w !sudo tee % > /dev/null


" === 編集系 ===
" ヤンクでクリップボードにコピー
set clipboard=unnamedplus
if system('uname -a | grep microsoft') != ''
  augroup myYank
    autocmd!
    autocmd TextYankPost * :call system('clip.exe', @")
  augroup END
endif
" 常にglobal
set gdefault
" 保存時に行末の空白を削除する
autocmd BufWritePre * :%s/\s\+$//ge
" ファイルを開き直してもundoできる
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
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" nerdtree
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" インクルードパス
augroup cpp-path
    autocmd!
    autocmd FileType cpp setlocal path=.,/usr/include,/usr/local/include
augroup END


" === プラグイン ===
" - vim-airline
" テーマ
let g:airline_theme = 'google_dark'
" powerline系フォントを利用
let g:airline_powerline_fonts = 1
" ステータスバーの項目を変更
let g:airline_section_a = airline#section#create(['mode', 'crypt'])
" ステータスバーでフルパスを表示
let g:airline_section_c = '%F'
" bufferタブを表示
let g:airline#extensions#tabline#enabled = 1
" bufferタブに番号を表示
let g:airline#extensions#tabline#buffer_idx_mode = 1
" ファイルパスの表示形式
let g:airline#extensions#tabline#formatter = 'unique_tail'

" - vim_markdown
let g:vim_markdown_folding_disabled = 1

" - previm
let g:previm_enable_realtime = 1
let g:previm_open_cmd = 'google-chrome'

" - coc.nvim
" <Tab>で候補を選択する関数
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
" 補完表示時のEnterで改行をしない
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
" 補完候補の選択をTab/Shitf-Tabで変更
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1):
  \ <SID>check_back_space() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<S-TAB>" " "\<C-h>"
