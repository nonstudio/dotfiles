
"--------------------------------
"          基本的な設定
"--------------------------------

" vi互換モードをオフにする(vimの拡張機能を有効)
set nocompatible

" 一旦ファイルタイプ関連を無効化する
filetype off

" vimでコピーした文字列がOSレベルのクリップボードで保持できるようにする
set clipboard+=unnamed

" スワップファイルを作らない
set noswapfile

" ラップファイルを作らない
set nowrapscan

" バックアップファイルを作らない
set nobackup

" ターミナル接続を高速にする
set ttyfast

" 編集中でも保存しないで他のファイルを開けるようにする
set hidden

" 'Unicode'で行末が変になる問題を解決する
set ambiwidth=double

" ファイルを保存していない場合に、ファイルの保存を確認するダイアログを出す
set confirm

" 画面下部のコマンドラインの高さ
set cmdheight=2

" カーソルの上または、下に表示される最小限の行数
set scrolloff=10

" ビープを鳴らさない
set vb t_vb=

" ビープの代わりにビジュアルベルを使う
set visualbell

" 全モードでマウスを有効化
set mouse=a

" 'yankring'用に'!'を追加する
set viminfo+=!

" パス区切りをスラッシュにする
set shellslash

" 整形オプションにマルチバイト系を追加する
set formatoptions+=mM

" キーコードはすぐにタイムアウトして、マッピングはタイムアウトしない
set notimeout ttimeout ttimeoutlen=200

" 外部エディタで編集中のファイルが変更された時、自動的に読みなおす(削除された場合は読み直さない)
set autoread

" 外部エディタで編集中のファイルが変更された時、自動的に書きだす
set autowrite

" 権限のないファイルを編集した時、'sudo'で保存する
nmap ,sudo :w !sudo tee %<CR>

" 'TAB','EOF'などの特殊文字を表示する
set list
set listchars=tab:>-,extends:<,trail:-,eol:↲


"---------------------------------------
"          プラグインのセットアップ
"---------------------------------------
if 0 | endif

if has('vim_starting')
	if &compatible
		set nocompatible
	endif
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))


"---- NeoBundle(プラグイン管理プラグインのセットアップ) -----
NeoBundleFetch 'Shougo/neobundle.vim'

let g:make ='gmake'
if system('uname -o') =~ '^GUN/'
	let g:make = 'make'
endif


"---------------------------------------------------------------
"         NeoBundleで管理するプラグインのセットアップ

" 'vimproc' 非同期処理の為
NeoBundle 'Shougo/vimproc', {
	\ 'build' : {
	\ 'windows' : 'make -f make_mingw32.mak',
	\ 'cygwin' : 'make -f make_cygwin.mak',
	\ 'mac' : 'make -f make_mac.mak',
	\ 'unix' : 'make -f make_unix.mak',
	\ },
\ }

if has('mac')
	" 'vimproc_mac.so'が無いというエラーが発生した場合
	let g:vimproc_dll_path = $VIMRUNTIME . '/autoload/vimproc_mac.so'
endif


"---------- 各種便利機能 ----------

" 'vim'におけるクロージャーの開発環境
NeoBundle 'VimClojure'

" 'vim'からシェルを起動する
NeoBundle 'Shougo/vimshell'

" 'switch.vim'(文字列の変換機能)
NeoBundle 'AndrewRadev/switch.vim'

" URLを開いたり、'google'検索が可能
NeoBundle 'tyru/open-browser.vim'

" ツリー型のファイル表示(':NERDTree'コマンド)
NeoBundle 'scrooloose/nerdtree'

" コメントアウト<Leader> c <Space> コメントアウト解除<Leader>cu<
NeoBundle 'scrooloose/nerdcommenter'

" 各種ソースコードを素早く実行する
NeoBundle 'thinca/vim-quickrun'

" シングルクウォートとダブルクウォートの入れ替え
NeoBundle 'tpope/vim-surround'

" 括弧やダブルクォーテーションを自動で閉じる
NeoBundle 'Townk/vim-autoclose'

" コメントの ON/OFF を簡単に実行する
NeoBundle 'tomtom/tcomment_vim'

" 'vim'から'Git'コマンドを使う
NeoBundle 'tpope/vim-fugitive'

"---------- ファイル強化機能 ----------

" コマンドラインでのファイル補完
NeoBundle 'kien/ctrlp.vim.git'

" Unite.vim(ファイルオープンを便利にする)
NeoBundle 'Shougo/unite.vim'

" 'Unite.vim'で最近使ったファイルを表示できるようにする
NeoBundle 'Shougo/neomru.vim'

"---------- 入力補完 ----------

"-- 超強力補完機能 --
if has('lua')
	NeoBundleLazy 'Shougo/neocomplete.vim', {
				\ 'depends' : 'Shougo/vimproc',
				\ 'autoload' : { 'insert' : 1,}
				\ }
endif

" neocomplete {{{
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 3
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000
let g:neocomplete#enable_fuzzy_completion         = 1
let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'
" }}}

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'


"---------  'emmet-vim' ----------

NeoBundle 'mattn/emmet-vim', {
	\ 'autoload' : {
		\ 'filetypes' : ['html', 'html5', 'eruby', 'jsp', 'xml', 'css', 'scss', 'coffee'],
		\ 'commands' : ['<Plug>ZenCodingExpandNormal']
		\ }}
" emmet {{{
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
			\ 'lang' : 'ja',
			\ 'html' : {
			\ 'indentation' : '  '
			\ }}
" }}}

NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'othree/html5.vim'


"---------- javascript ----------
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'moll/vim-node'
NeoBundle 'pangloss/vim-javascript'


"---------- 'Ruby/Rails' ----------

" 文法エラー、スタイルチェック
NeoBundle 'bbatsov/rubocop'

" 'Rails'プロジェクト用プラグイン
NeoBundle 'tpope/vim-rails'

" キーワードの自動補完
NeoBundle 'tpope/vim-endwise'


"---------- vim-markdown ----------

NeoBundle 'rcmdnk/vim-markdown'
" vim-markdown {{{
let g:vim_markdown_folding_disabled = 1
" }}}

"---------- 'Python' ----------

" コーディング規約に違反していないかのチェック
NeoBundle 'andviro/flake8-vim'

" インデント単位でオブジェクトを使う機能
NeoBundle 'bps/vim-textobj-python'

" インデントの挙動を正して規約を守る
map ,P <Plug>(operator-autopep8)

"---------- 色付け、表示関連 ----------

" vim-indent-guides(インデントに色付けして見やすくする)
NeoBundle 'nathanaelkane/vim-indent-guides'

" シンタックスのチェックをする(重たくなるようなので)
NeoBundle 'scrooloose/syntastic'

" 'less'用のシンタクスハイライト
NeoBundle 'kohPoll/vim-less'

" ログファイルを色付け
NeoBundle 'vim-scripts/AnsiEsc.vim'

"----- ステータスライン -----

" Powerline
NeoBundle 'Lokaltog/powerline', {'rtp' : 'powerline/bindings/vim'}

" vim-airline
NeoBundle 'bling/vim-airline'

"------ カラースキーマ -----

NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'altercation/vim-colors-solarized'

"         / Plugin ここまで
"--------------------------------------

call neobundle#end()
filetype plugin indent on


" '.vimrc'に記述されたプラグインでインストールされていないものがないかチェックする
NeoBundleCheck

"        / プラグインセットアップ ここまで
"------------------------------------------------



"------------------------------------------------
"       セットアップしたプラグインの設定

"-------- 各種便利機能 -----------

"----- 'fugitive.vim' -----
" 'grep'検索の実行後に'QuickFix List'を表示する
autocmd QuickFixCmdPost *grep* cwindow
" ステータスラインに現在の'git'ブランチを表示する
set statusline+=%{fugitive#statusline()}


"---------- ファイル強化機能 ----------

"----- 'Unite.vim' -----
" 入力モードで開始する
let g:unite_enable_start_insert=1
	" バッファ一覧
	noremap <C-P> :Unite buffer<CR>
	" ファイル一覧
	noremap <C-N> :Unite -buffer-name=file file<CR>
	" 最近使ったファイルの一覧
	noremap <C-Z> :Unite file_mru<CR>
	" 'sources'を「今開いているファイルのディレクトリ」とする
	noremap uft :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
	" ウィンドウを分割して開く
	au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
	au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
	" ウィンドウを縦に分割して開く
	au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
	au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
	" 'ESCキー'を２回押すと終了する
	au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
	au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>


"---------- ステータスライン ----------

"----- vim-airline -----
let g:airline_theme = 'badwolf'
let g:airline_section_b = "%t %M"
let g:airline_section_c = ''
let s:sep = " %{get(g:, 'airline_right_alt_sep', '')} "
let g:airline_section_x =
	\ "%{strlen(&fileformat)?&fileformat:''}".s:sep.
	\ "%{strlen(&fenc)?&fenc:&enc}".s:sep.
	\ "%{strlen(&filetype)?&filetype:'no ft'}"
let g:airline_section_y = '%3p%%'
let g:airline_section_z = get(g:, 'airline_linecolumn_prefix', '').'%3l:%-2v'
let g:airline#extentions#whitespace#enabled = 0

"        / プラグインの設定 ここまで
"------------------------------------------------



"----------------------------------------
"            カラースキーム
"----------------------------------------

syntax enable
colorscheme lucius
set background=dark
set t_Co=256


"----------------------------------------
"           ステータスライン
"----------------------------------------

" ステータスラインにコマンドを表示する
set showcmd

" エディタウィンドウの末尾から２行目にステータスラインを常時表示させる
set laststatus=2

" ステータスラインに現在の'git'ブランチを表示する
set statusline+=%{fugitive#statusline()}

"----- 挿入モード時、ステータスラインの色を変更 -----
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
	autocmd InsertEnter * call s:StatusLine('Enter')
	autocmd InsertLeave * call s:StatusLine('Leave')
	augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
	if a:mode == 'Enter'
		silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
		silent exec g:hi_insert
	else
		highlight clear StatusLine
		silent exec s:slhlcmd
	endif
endfunction

function! s:GetHighlight(hi)
	redir => hl
	exec 'highlight '.a:hi
	redir END
	let hl = substitute(hl, '[\r\n]', '', 'g')
	let hl = substitute(hl, 'xxx', '', '')
	return hl
endfunction


"----------------------------------------
"           インデント
"----------------------------------------

" 新しい行のインデントを現在業と同じにする
set autoindent

" スマートインデント
set smartindent

" 新しく行を作った時に、高度な自動インデントを行う
set smarttab

" 'C'プログラムの自動インデント
set cindent

" タブ文字の表示幅
set tabstop=4

" オートインデント時に、インデントする文字数
set shiftwidth=4

" タブ文字の挿入される空白の量
set softtabstop=0

" 'Ruby'スクリプトではインデントをスペース2個にする
au FileType ruby setlocal ts=2 sw=2

" vimを立ち上げた時に、自動的に'vim-indent-guides'をオンにする
let g:indent_guides_enable_on_vim_startup = 1

" ガイドをスタートするインデントの量
let g:indent_guides_start_level = 1

" 自動カラーを無効にする
let g:indent_guides_auto_colors = 0

" 奇数インデントのカラー
autocmd VimEnter,Colorscheme *hi IndentGuidesOdd guifg=#3c3c3c guibg=#3c3c3c gui=none ctermfg=gray ctermbg=gray cterm=none

" 偶数インデントのカラー
autocmd VimEnter,Colorscheme *hi IndentGuidesEven guifg=#6c6c6c guibg=#6c6c6c gui=none ctermfg=lightgray ctermbg=lightgray cterm=none


"----------------------------------------
"                表示
"----------------------------------------

" 構文毎に文字色を変化させる
syntax on

"----- カーソルラインをハイライト表示する -----
set cursorline
:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=darkgray guibg=darkgray

" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

"----- 最後のカーソル位置を復元する -----
if has("autocmd")
	autocmd BufReadPost *
				\ if line("'\"") > 0 && line("'\"") <= line("$") |
				\ exe "normal! g'\"" |
				\ endif
endif


" 行間の設定
set linespace=4

" 行番号を表示する
set number

" 行番号の幅
set numberwidth=5

" 行番号の色
highlight LineNr ctermfg=white

" 括弧の対応をハイライト表示する
set showmatch

" 自動的に閉じ括弧を入力
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

" ウィンドウのタイトルを書き換える
set title

" 長い行を折り返す
set wrap

" 現在のモードを表示する
set showmode

" ----- 全角スペースのハイライト表示 -----
function! ZenkakuSpace()
	highlight ZenkakuSpace cterm=underline ctermfg=lightmagenta guifg=darkgray
endfunction

if has('syntax')
	augroup ZenkakuSpace
		autocmd!
		autocmd ColorScheme * call ZenkakuSpace()
		autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '__')
	augroup END
	call ZenkakuSpace()
endif


"----------------------------------------
"             補完
"----------------------------------------

" コマンドラインモードでの補完を有効にする
set wildmenu

" コマンド補完を開始するキー
set wildchar=<tab>

" コマンド・検索パターンの履歴数
set history=1000
set completeopt=menu,preview,menuone


"----------------------------------------
"             検索
"----------------------------------------

" 最後まで検索したら先頭に戻る
set wrapscan

" 大文字小文字を無視する
set ignorecase

" 検索文字列に大文字が含まれている場合は区別する
set smartcase

" 検索後を強調表示
set hlsearch

" インクリメンタルサーチを有効化
set incsearch

" 内蔵'grap'を使う
set grepprg=internal

" 'Esc'の2回押しでハイライトを消去する
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>

" 'cd','lcd'コマンドで検索されるディレクトリのリスト
:let &cdpath = ',' . substitute(substitute($CDPATH, '[, ]','\\\0', 'g'), ':', ',', 'g')


"----------------------------------------
"         エンコーディング
"----------------------------------------

" 改行文字
set ffs=unix,dos,mac
set encoding=utf-8
scriptencoding utf-8
set fileencodings=iso-2022-jp,cp932,eur-jp,utf-8,utf-32

" フォント
set guifont=Andale\ Mono:h16
"set guifont=Menlo-Regular-Powerline\ Regular:h16
"set guifonrwide=Menlo\ Regular:h16

" フォントを滑らかにする
set antialias


"----------------------------------------
"            折り畳み
"----------------------------------------

" 自動で折り畳み
set foldmethod=syntax


"----------------------------------------
"        ウィンドウの設定
"----------------------------------------

" ウィンドウポジション
winpos 546 0

" ウィンドウの幅
set columns=88

" ウィンドウの高さ
set lines=48

"----- ウィンドウ位置とサイズの自動保存と復元 -----
let g:save_window_file = expand('~/.vim/vimfiles/.vimwinpos')
augroup SaveWindow
	autocmd!
	autocmd VimLeavePre * call s:save_window()
	function! s:save_window()
		let options = [
			\ 'set columns=' . &columns,
			\ 'set lines=' . &lines,
			\ 'winpos ' . getwinposx() . ' ' . getwinposy(),
			\ ]
		call writefile(options, g:save_window_file)
	endfunction
augroup END

if filereadable(g:save_window_file)
	execute 'source' g:save_window_file
endif


"----- 'filetype'の自動検出(最後の方に書いた方がいいらしい) -----
filetype on

