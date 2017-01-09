let $PATH = "~/.pyenv/shims:".$PATH

"""---dein scripts---"""
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

call dein#add('sjl/badwolf')

call dein#add('kana/vim-smartinput')
call dein#add('scrooloose/syntastic')
call dein#add('Shougo/neocomplete.vim')
call dein#add('scrooloose/nerdtree')

call dein#add('davidhalter/jedi-vim', {
  \ 'autoload': {
  \ 'filetypes':['python']
  \}})

call dein#add("lambdalisue/vim-pyenv", {
  \  "depends": ["jedi-vim"], "merged": 0,"on_ft": ["python", "python3"]
  \})

call dein#add('fatih/vim-go', {
  \ 'autoload': {
  \ 'filetypes':['go']
  \}})

call dein#end()

filetype plugin indent on
syntax enable

"neocomplete
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

"jedi-vim
autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType python setlocal completeopt-=preview
let g:jedi#force_py_version=3
let g:jedi#auto_vim_configuration = 1
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

"go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
autocmd FileType go setlocal completeopt-=preview

"nerdTree
nnoremap <silent><C-e> :NERDTreeToggle<CR> "ctrl-eで開く

"badwolf
let g:badwolf_darkgutter = 1
let g:badwolf_tabline = 1
let g:badwolf_html_link_underline = 1
let g:badwolf_css_props_highlight = 1

"""---end dein scripts---""""

"カラースキーム設定
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none

syntax on 
"set background=dark
colorscheme badwolf

"画面表示設定
set number
set cursorline
set showmatch

"ファイル処理設定
set noswapfile
set confirm
set title
set hidden
set nobackup
set writebackup
set foldmethod=marker
"set paste
set display=uhex
set clipboard&
set clipboard+=unnamedplus

"文字コード設定
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jpset 
set fencs=utf-8,iso-2022-jp,enc-jp,cp932
language en_US.UTF-8

"タブとかの設定
set tabstop=2
set shiftwidth=2
set expandtab

"インデント設定
inoremap <F5> <nop>
set pastetoggle=<F5>

"ステータスライン設定
set t_Co=256
set statusline=%F "ファイル名表示
set statusline+=%m "変更チェック表示
set statusline+=%r "読み込み専用かどうか表示
set statusline+=%h "ヘルプページなら[HELP]と表示
set statusline+=%w "プレビューウインドウなら[Prevew]と表示
set statusline+=%= "これ以降は右寄せ表示
set statusline+=[ENC=%{&fileencoding}] "file encoding
set statusline+=%y "file type
set statusline+=[LOW=%l/%L] " 現在行数/全行数
set laststatus=2
highlight StatusLine term=bold cterm=bold ctermfg=black ctermbg=blue

"キーマッピング
imap <C-j> <Down>
imap <C-k> <Esc><Up> i
imap <C-h> <Left>
imap <C-l> <Right>
"imap <C-x> <Del>
"imap <C-i> <BS>
imap <C-u> <Esc>:undo<CR> i
imap <C-d><C-d> <Esc>dd i

"いろいろ
set backspace=eol,indent,start
inoremap <C-f><C-f> <ESC>

"Python
autocmd Filetype python setl autoindent
autocmd FileType python setlocal completeopt-=preview
autocmd Filetype python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,pass,

"C & CPP
autocmd FileType c setl cindent
autocmd FileType cpp setl cindent
autocmd BufNewFile *.cpp 0r ~/.vim/template/cpp.cpp

"Go
autocmd FileType go setl ts=4 sw=4 sts=4 noet

"HTML & xml
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd FileType html inoremap <buffer> </ </<C-x><C-o>
augroup END
