autocmd!
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
Bundle 'kien/ctrlp.vim'
Bundle 'godlygeek/tabular'
Bundle 'rodjek/vim-puppet'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'klen/python-mode'
Bundle 'vim-scripts/taglist.vim'
Bundle 'voithos/vim-python-matchit'
Bundle 'xolox/vim-easytags'
Bundle 'xolox/vim-misc'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'vim-scripts/csv.vim'

filetype plugin indent on

set relativenumber
syntax on
set background=dark
colors solarized
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

" Relative Numbering
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
autocmd WinEnter * :setlocal relativenumber
autocmd WinLeave * :setlocal number

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'
set laststatus=2

" Exit modes immediately
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" GUI stuff
if has('gui_running')
    set background=dark
    colors solarized
    set columns=180
    set lines=54
    set guifont=Source_Code_Pro_for_Powerline:h13
    set guioptions-=T
    set guioptions-=m
    set guioptions+=LlRrb
    set guioptions-=LlRrb
endif

let mapleader=","
map <F3> :TlistToggle<CR>:10wincmd h<CR>

noremap j gj
noremap k gk
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

runtime macros/matchit.vim

" Filetype configurations
autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

" Easy Tags
let g:easytags_updatetime_warn = 0
set tags=./.tags;
let g:easytags_dynamic_files = 2

function! UpdateProjectTags()
    let g:easytags_autorecurse = 1
    :UpdateTags
    let g:easytags_autorecurse = 0
endfunction

map <F4> :call UpdateProjectTags()<CR>

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(pyc)$',
    \ }

" Python-Mode
let g:pymode_lint = 0 " let syntastic do linting
let g:pymode_virtualenv = 0
let g:pymode_breakpoint = 0
let g:pymode_syntax_print_as_function = 1
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_highlight_string_format = 1
let g:pymode_syntax_highlight_builtin_objs = 1
let g:pymode_indent = 1
let g:pymode_run = 0
let g:pymode_rope_vim_completion = 0 "use jedi
let g:pymode_rope_autocomplete_map = '<C-Tab>' "just make this mostly useless
let g:pymode_folding = 0
