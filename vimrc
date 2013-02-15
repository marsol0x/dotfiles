set nu
colors desert
syntax on
set encoding=utf-8
set hlsearch

set backspace=indent,eol,start
set noswapfile
set autoindent
set copyindent
set ttyfast

set ruler
set shiftwidth=4 softtabstop=4 tabstop=4 expandtab
"set textwidth=79
set listchars=tab:▸\ ,eol:¬
"set list

set guioptions-=T
set guioptions-=m
set guioptions+=LlRrb
set guioptions-=LlRrb

if has("gui_running")
    colors molokai
    set columns=140
    set lines=55
endif


let g:Powerline_symbols = 'fancy'
set laststatus=2

let mapleader=","
map <F2> :NERDTreeToggle<CR>

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

set nocompatible
filetype off    " Required

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Have Vundle manage Vundle
" Required
Bundle 'gmarik/vundle'

" My bundles go here
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-powerline'
Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on
