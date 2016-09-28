" Initialize plugins with dein.vim {{{
" Disable vi compatibility
if &compatible | set nocompatible | endif

 " Reset autocmd
augroup MyAutoCmd
  autocmd!
augroup END

" Automatically install dein.vim
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone --depth 1 https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

" Load plugins & create cache
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif

" Automatically install and update plugins
if has('vim_starting')
  let s:dein_last_update_marker = g:dein#_base_path . '/last_update_maker'
  " Install new plugins
  if dein#check_install()
    call dein#install()
    call writefile([strftime('%s')], s:dein_last_update_marker)
  endif
  " Update plugins regulary
  if getftime(s:dein_last_update_marker) < strftime('%s') - 3600 * 24 * 7
    call dein#update()
    call writefile([strftime('%s')], s:dein_last_update_marker)
  endif
endif

" lazyプラグインがvim起動時にsourceされてしまう場合(on_ft対象のファイルを開くときなど)でも hook_post_source が機能するようにする
autocmd MyAutoCmd VimEnter * call dein#call_hook('post_source')
" }}}

" General {{{
" Enable indent for specific file types
filetype indent on

" Set to auto road when a file is changed from the outside
set autoread
" }}}

" Interface {{{
" Set 7 liens to the cursor
set so=7

" Turn on the wild menu
set wildmenu

" Enable line numbers
set number

" Heighet of the command bar
set cmdheight=2

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=.git\*,.hg\*,.svn\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Allow backspace in insert mode
set backspace=indent,eol,start

" Ignore case of searches
set ignorecase

" Override the ignorecase option when the pattern contains upper case
set smartcase

" Highlight search results
set hlsearch

" Highlight dynamically as pattern is typed
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell

" Add a bit extra margin to the left
set foldcolumn=1
" }}}

" Colors and Fonts {{{
" Enable syntax highlighting
syntax on

" Set UTF-8 without BOM as standard encoding
set encoding=utf-8 nobomb
" set fileencodings=ucs-bom,iso-2022-jp,utf-8,cp932,euc-jp,utf-16le,utf-16be,latin1

" Set Unix as the standard file type
set ffs=unix,dos,mac
" }}}

" File backup {{{
" Turn backup off
set nobackup
set nowritebackup
" }}}

" Text, tab and indent related {{{
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" Make tabs as wide as two spaces
set shiftwidth=2
set tabstop=2

" Enable smart indent
set autoindent
set smartindent

" Wrap lines
set wrap
set lbr

" Visualize tabs and spaces
set list
set listchars=tab:>-,trail:-,nbsp:%
" }}}

" Key map {{{
" Fast saving
nnoremap <Space>w :w<cr>

" Disable highlight when <Esc><Esc> is pressed
nnoremap <silent> <Esc><Esc> :noh<CR>

" Smart way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Close the current buffer
nnoremap <Space>bd :bd<CR>
" }}}

" Language {{{
"" Ruby
" Add '?' to keywords
autocmd MyAutoCmd FileType ruby setl iskeyword+=?
" }}}

" vim: foldmethod=marker
