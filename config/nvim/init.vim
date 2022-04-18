" vim-plug
call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

syntax on
set termguicolors
set background=dark
"colors handmade-hero
colors NeoSolarized
set encoding=utf-8
set title
set nohlsearch
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set history=1000
set wildmode=list:longest
set visualbell
set nowrap
set linebreak
set noswapfile
set autoindent
set copyindent
set backspace=indent,eol,start
set sw=4 sts=4 ts=4 expandtab
set listchars=tab:▸\ ,eol:¬
set so=2
set modeline
set laststatus=2
set nofoldenable
set hidden
set bufhidden=hide
set mouse=n

set guifont=Liberation\ Mono:h12

" Use Ag for searching
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

" Statusline
set statusline=             " Reset
"set statusline+=[%n]\       " Buffer number
set statusline+=%f\         " File name
set statusline+=%4m         " Modify flag
set statusline+=%r          " Read-only flag
set statusline+=%w          " Preview Flag
set statusline+=%=          " Right align on status line
set statusline+=%y          " File type
set statusline+=[%{&ff}]    " File format
set statusline+=[%{&enc}]   " Encoding
set statusline+=%10l,%v     " Line number, column number
set statusline+=\ %10P      " Percentage through file

" Mappings
let mapleader=','
map <leader>n :bn<CR>
map <leader>p :bp<CR>
map <leader><leader> :b#<CR>
nmap <leader>s :w<CR>
map <F8> :wa\|make<CR><CR>

noremap j gj
noremap k gk
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

map <c-,> <c-w>w
imap <D-v> <c-r>*
vmap <D-c> "*y
vmap <D-x> "*d

" FZF Mappings
map <c-p> :FZF<CR>
map <leader>b :Buffers<CR>
map <c-I> :BTags<CR>
map <leader>t :Tags<CR>
map <leader>g :Ag<CR>
let g:fzf_preview_window=''
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }
