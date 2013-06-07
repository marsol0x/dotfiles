set nocompatible

set nu
syntax on
colors molokai
set encoding=utf-8
set title
set hlsearch
set incsearch
set ignorecase
set showcmd
set history=1000
set wildmode=list:longest
set visualbell
set linebreak

set backspace=indent,eol,start
set noswapfile
set autoindent
set copyindent
set ttyfast

set ruler
set shiftwidth=4 softtabstop=4 tabstop=4 expandtab
set listchars=tab:▸\ ,eol:¬
set cursorline

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'
set laststatus=2

let mapleader=","
map <F2> :NERDTreeToggle<CR>
map <F3> :TlistToggle<CR>:10wincmd h<CR>

noremap j gj
noremap k gk
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
Bundle 'Lokaltog/powerline'
Bundle 'Valloric/YouCompleteMe'
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'godlygeek/tabular'
Bundle 'rodjek/vim-puppet'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/python.vim--Vasiliev'
Bundle 'vim-scripts/taglist.vim'
Bundle 'voithos/vim-python-matchit'
Bundle 'xolox/vim-easytags'
Bundle 'xolox/vim-misc'

filetype plugin indent on

runtime macros/matchit.vim

" NERDTree Ignores
let NERDTreeIgnore = ['\.pyc$']

" Filetype configurations
autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

" CTags
map <F4> :!ctags --tag-relative=yes -o .tags -R . 2>/dev/null<CR><CR>
set tags=.tags
