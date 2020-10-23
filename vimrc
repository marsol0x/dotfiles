" TODO(marshel):
"   - Projects Files
"       - Determine build command
"       - Always override TAG files and keep them up-to-date
"   - Quickfix
"       - Only open if there are changes
"       - Builds should mention that they succeeded or not
"   - Replication 'other-window' behavior from emacs
"   - Color TODO, NOTE, and IMPORTANT
"   - Fix syntax highlighting?
"       - Should keywords and strings be highlighted?

set t_Co=256                  " Number of supported color
set t_ut=                     " Clear using current bg color
autocmd!
set nocompatible              " This ain't your daddy's vi
filetype off                  " Required for plugins

set rtp+=~/.vim/bundle/Vundle.vim " Set vundle as our runtime path
"set rtp+=/usr/local/opt/fzf " FZF
call vundle#rc()              " Start vundle

" Have Vundle manage Vundle
" Required
Plugin 'VundleVim/Vundle.vim'

" My bundles go here
Plugin 'mtth/scratch.vim'
Plugin 'tommcdo/vim-lion.git'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

filetype plugin indent on

syntax on
set background=dark
colors wombat
set encoding=utf-8
set title                       " Set window title to show filename and path
set nohlsearch                  " Highlight all search matches
set incsearch                   " Highlight search matches as I type
set ignorecase                  " Ignore case in pattern matching
set smartcase                   " Override ignorecase if we include an uppercase character
set showcmd                     " Show commands as I type them
set showmode                    " Show what mode I'm in
set history=1000                " History size for commands, search, etc
set wildmode=list:longest       " List all possible matches when I auto-complete
set visualbell                  " Beeping is annoying
set nowrap
set linebreak                   " When wrapping, wrap on the word, rather than the character
set noswapfile                  " Disable swapfiles
set autoindent                  " Autoindent each newline to same indent of prev line
set copyindent                  " Copy the indent when indenting
set backspace=indent,eol,start  " Backspace autoindent and such
set ttyfast                     " I have a fast terminal
set sw=4 st=4 ts=4 expandtab    " Shift width, soft tab, tab stop == 4, use spaces, not tabs
set listchars=tab:▸\ ,eol:¬
set so=2                        " Minimum number of screenlines for scrolling
set modeline                    " Respect modelines in files
set laststatus=2                " Always show the status line
set nofoldenable                " Disable folding
set hidden                      " Modified buffers can be hidden
set bufhidden=hide              " Hide buffers, rather than unload them
" set autowrite=on               " Auto-save buffer when it is hidden

" Wildcard expantion ignore list
set wildignore+=*.git*
set wildignore+=*/venv/*
set wildignore+=*.o
set wildignore+=*.pyc

" Statusline
set statusline=             " Reset
"set statusline+=[%n]\         " Buffer number
set statusline+=%f\       " File name
set statusline+=%4m         " Modify flag
set statusline+=%r          " Read-only flag
set statusline+=%w          " Preview Flag
set statusline+=%=          " Right align on status line
set statusline+=%y          " File type
set statusline+=[%{&ff}]    " File format
set statusline+=[%{&enc}]   " Encoding
set statusline+=%10l,%v     " Line number, column number
set statusline+=\ %10P      " Percentage through file

" Mouse Stuff
set mouse=n " Enable the mouse in normal mode
set ttymouse=xterm2

" Filetype configurations
au FileType ruby setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
au FileType gitcommit setlocal spell sw=4 st=4 ts=4 expandtab
au FileType go setlocal noexpandtab makeprg=go\ install 
au BufRead,BufWrite pom.xml set sw=2 st=2 ts=2 expandtab
au BufRead,BufWrite *.conf set ft=config
au BufRead,BufWrite *.cs set ff=dos
au BufRead *.java set efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#

" Skeletons
au BufNewFile *.c,*.cpp,*.cc,*.java
    \ 0r ~/.vim/skeletons/skel.c
    \ | %s/YEAR/\=strftime("%Y")/g
    \ | %s/TODAY/\=strftime("%d %B %Y")/g
    \ | %s/FILENAME/\=expand("%:t")/g
    \ | $
au BufNewFile *.go
    \ 0r ~/.vim/skeletons/skel.go
    \ | %s/YEAR/\=strftime("%Y")/g
    \ | %s/TODAY/\=strftime("%d %B %Y")/g
    \ | %s/FILENAME/\=expand("%:t")/g
    \ | $
au BufNewFile *.h,*.hpp
    \ 0r ~/.vim/skeletons/skel.h
    \ | %s/YEAR/\=strftime("%Y")/g
    \ | %s/TODAY/\=strftime("%d %B %Y")/g
    \ | %s/FILENAME_H/\=toupper(expand("%:t:r"))."_".toupper(expand("%:t:e"))/g
    \ | %s/FILENAME/\=expand("%:t")/g
    \ | 10
au BufNewFile *.sh,*.bash
    \ 0r ~/.vim/skeletons/skel.sh
    \ | %s/YEAR/\=strftime("%Y")/g
    \ | %s/TODAY/\=strftime("%d %B %Y")/g
    \ | %s/FILENAME/\=expand("%:t")/g
    \ | $
au BufNewFile *.py
    \ 0r ~/.vim/skeletons/skel.py
    \ | %s/YEAR/\=strftime("%Y")/g
    \ | %s/TODAY/\=strftime("%d %B %Y")/g
    \ | %s/FILENAME/\=expand("%:t")/g
    \ | $
au BufNewFile *.sql
    \ 0r ~/.vim/skeletons/skel.sql
    \ | %s/TODAY/\=strftime("%d %B %Y")/g
    \ | %s/FILENAME/\=expand("%:t:r")/g
    \ | $

" Mappings
noremap j gj
noremap k gk
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" Leader shortcuts
let mapleader=","
map <leader>n :bn<CR>
map <leader>p :bp<CR>
map <leader><leader> :b#<CR>
nmap <leader>s :w<CR>
map <F8> :wa\|make<CR><CR>

" FZF mappings
map <c-p> :FZF<CR>
map <leader>b :Buffers<CR>
map <leader>t :Tags<CR>
map <leader>g :Ag<CR>
let g:fzf_preview_window = ''

" Use Ag for searching
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

" Quickfix
function OpenPrefixWindow()
    if (filter(range(1, winnr("$")), 'getwinvar(v:val, "&ft") == "qf"') == [])
        let current_window = winnr()
        wincmd o
        copen
        if (current_window == 1)
            wincmd L
        else
            wincmd H
        endif
    endif
endfunction

let &makeef=tempname()
au QuickFixCmdPost * :call OpenPrefixWindow()

if filereadable("./build.sh")
    set makeprg=./build.sh
elseif filereadable("./build.xml")
    set makeprg=ant
endif

" Projects
set tags=./TAGS

let g:project_root = ""
let g:tag_update_job = 0
function UpdateTags()
    if g:project_root != ""
        let tag_file = g:project_root . "/TAGS"
        execute "set tags=" . tag_file
        if g:tag_update_job == 0 || job_status(g:tag_update_job) != "run"
            if g:tag_update_job != 0
                job_stop(s:tag_update_job)
            endif
            let source_path = g:project_root
            if source_path == ""
                let source_path = "."
            endif
            let g:tag_update_job = job_start(["ctags", "-f", tag_file, "-R", source_path])
        endif
    endif
endfunction

function OpenProject(project_file)
    if getfsize(a:project_file) > 0
        let file_content = readfile(a:project_file, "", 1)
        let source_path = file_content[0]
        if isdirectory(source_path)
            let g:project_root = source_path
            cd `=source_path`
            UpdateTags()
        endif
    endif
endfunction

set updatetime=1000
au CursorHold,CursorHoldI * silent! :call UpdateTags()<CR>
au BufRead *.prj silent! :call OpenProject(expand("%"))

function! MaximizeWindow()
    set lines=999999
    set columns=999999
endfunction

" GUI stuff
if has('gui_running')
    colors mjh
    highlight NonText guifg=bg

    set cursorline                  " Highlight the line I am on
    set guifont=Liberation\ Mono:h12
    set guioptions-=T
    set guioptions-=m
    set guioptions+=LlRrb
    set guioptions-=LlRrb
    call MaximizeWindow()
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
