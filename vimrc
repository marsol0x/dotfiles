set t_Co=256                  " Number of supported color
set t_ut=                     " Clear using current bg color
autocmd!
set nocompatible              " This ain't your daddy's vi
filetype off                  " Required for plugins

set rtp+=~/.vim/bundle/vundle " Set vundle as our runtime path
call vundle#rc()              " Start vundle

" Have Vundle manage Vundle
" Required
Plugin 'gmarik/vundle'

" My bundles go here
Plugin 'kien/ctrlp.vim'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'
"Plugin 'bling/vim-airline'
"Plugin 'airblade/vim-gitgutter'
"Plugin 'rodjek/vim-puppet'
"Plugin 'scrooloose/syntastic'
"Plugin 'tpope/vim-fugitive'
"Plugin 'klen/python-mode'
"Plugin 'voithos/vim-python-matchit'
"Plugin 'jnwhiteh/vim-golang'
"Plugin 'terryma/vim-multiple-cursors'
"Plugin 'jdonaldson/vaxe'
"Plugin 'embear/vim-localvimrc'
"Plugin 'godlygeek/tabular'

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
set showmode                    " Show what mode I'm in
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
set sw=4 st=4 ts=4 expandtab    " Shift width, soft tab, tab stop == 4, use spaces, not tabs
set listchars=tab:▸\ ,eol:¬
set cursorline                  " Highlight the line I am on
set so=2                        " Minimum number of screenlines for scrolling
set modeline                    " Respect modelines in files
set laststatus=2                " Always show the status line

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
au BufRead,BufWrite pom.xml set sw=2 st=2 ts=2 expandtab
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
map <leader>b :ls<CR>
map <leader>b :CtrlPBuffer<CR>
"map <leader><leader> :b#<CR>

" Easy Tags
set tags=.tags;~
let g:easytags_file = './.tags'
let g:easytags_dynamic_files = 1

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
    \ 'dir':  '\v[\/](.git|.hg|.svn|venv|bin|build|dist|target)$',
    \ 'file': '\v\.(pyc|class|jar)$',
    \ }

" Airline > powerline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Syntastic
let g:syntastic_java_javac_config_file_enabled = 1

" Git gutter
highlight clear SignColumn
let g:gitgutter_sign_column_always = 1

" Multi-line cursor
let g:multi_cursor_start_key='<Leader>v'

" Matchit, for % matching in Python conditionals
runtime macros/matchit.vim

" Syntastic
let g:syntastic_java_javac_config_file_enabled = 1

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
let g:pymode_rope = 0
let g:pymode_folding = 0

" GUI stuff
if has('gui_running')
    set columns=319
    set lines=75
    set guifont=Source\ Code\ Pro\ for\ Powerline:h10
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
    set term=screen-256color
endif

" Local Vimrc
let g:localvimrc_ask = 0
