set term=screen-256color
set t_Co=256                  " Number of supported color
set t_ut=                     " Clear using current bg color
autocmd!
set nocompatible              " This ain't your daddy's vi
filetype off                  " Required for plugins

set rtp+=~/.vim/bundle/vundle " Set vundle as our runtime path
call vundle#rc()              " Start vundle

" Have Vundle manage Vundle
" Required
Bundle 'gmarik/vundle'

" My bundles go here
Bundle 'bling/vim-airline'
Bundle 'airblade/vim-gitgutter'
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
Bundle 'jnwhiteh/vim-golang'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'derekwyatt/vim-scala'

filetype plugin indent on

syntax on
set background=dark
colors solarized
set encoding=utf-8
set title                       " Set window title to show filename and path
set hlsearch                    " Highlight all search matches
set incsearch                   " Highlight search matches as I type
set ignorecase                  " Ignore case in pattern matching
set showcmd                     " Show commands as I type them
set history=1000                " History size for commands, search, etc
set wildmode=list:longest       " List all possible matches when I auto-complete
set visualbell                  " Beeping is annoying
set linebreak                   " When wrapping, wrap on the word, rather than the character
set noswapfile                  " Disable swapfiles
set autoindent                  " Autoindent each newline to same indent of prev line
set copyindent                  " Copy the indent when indenting
set backspace=indent,eol,start  " Backspace autoindent and such
set ttyfast                     " I have a fast terminal
set ruler                       " Show line/col number, Airline does this regardless
set sw=4 st=4 ts=4 expandtab
set listchars=tab:▸\ ,eol:¬
set cursorline
set so=14                       " Minimum number of screenlines for scrolling

" Mouse Stuff
set mouse=n " Enable the mouse in normal mode
set ttymouse=xterm2

" Relative Numbering
set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
autocmd WinEnter * :setlocal relativenumber
autocmd WinLeave * :setlocal number

" Filetype configurations
autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
au BufRead,BufWrite *.conf set ft=config

" Mappings
noremap j gj
noremap k gk
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

let mapleader=","
map <leader>n :bn<CR>
map <leader>p :bp<CR>
map <leader><leader> :b#<CR>
map <F3> :TlistToggle<CR>:10wincmd h<CR>

" Airline > powerline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Git gutter
highlight clear SignColumn
let g:gitgutter_sign_column_always = 1

" Multi-line cursor
let g:multi_cursor_start_key='<Leader>v'

" Matchit, for % matching in Python conditionals
runtime macros/matchit.vim

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
map <leader>b :CtrlPBuffer<CR>

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

" GUI stuff
if has('gui_running')
    set columns=180
    set lines=54
    set guifont=Source\ Code\ Pro\ for\ Powerline\ h10
    set guioptions-=T
    set guioptions-=m
    set guioptions+=LlRrb
    set guioptions-=LlRrb
else
    " Exit modes immediately
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif
