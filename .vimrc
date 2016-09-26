" Initialize plugins with dein.vim {{{
" Disable vi compatibility
if ! &compatible | set nocompatible | endif

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
au MyAutoCmd VimEnter * call dein#call_hook('post_source')
" }}}

" Enable syntax highlighting
syntax on
" Enable line numbers
set number
" Allow backspace in insert mode
set backspace=indent,eol,start
set expandtab

" Make tabs as wide as two spaces
set tabstop=2
set shiftwidth=2
" Enable smart indent
set autoindent
set smartindent
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" set fileencodings=ucs-bom,iso-2022-jp,utf-8,cp932,euc-jp,utf-16le,utf-16be,latin1
" Visualize tabs and spaces
set list
set listchars=tab:>-,trail:-,nbsp:%

"""
" Language
"""

" Language {{{
"" Ruby
" Add '?' to keywords
au MyAutoCmd FileType ruby setl iskeyword+=?
" }}}

" vim: foldmethod=marker
