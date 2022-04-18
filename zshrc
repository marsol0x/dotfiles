autoload -U colors && colors
# PATHS
export PATH="./venv/bin:$HOME/.bin:/usr/local/sbin:/usr/local/bin:$PATH"

# Prompt
setopt prompt_subst
#export PROMPT='%(1j.(%F{cyan}%j%F{reset}) .)$(_fishy_collapse_wd)$(_vcs_branch)$(_vcs_status) %(!.$F{red}#%f.%F{blue}\$%f) '
export PROMPT='%(1j.(%F{cyan}%j%F{reset}) .)$(_fishy_collapse_wd) %(!.$F{red}#%f.%F{blue}\$%f) '

# Dircolors
if [[ `uname` = "Darwin" ]]
then
    eval `gdircolors ~/.dircolors`
else
    eval `dircolors ~/.dircolors`
fi

export PROJECTS=~/Documents/Projects
export LAB=~/Documents/Lab

# Aliases
if [[ `uname` = "Darwin" ]]
then
    alias ls="gls -F --group-directories-first --color=auto"
    alias stat="gstat"
else
    alias ls="ls -F --group-directories-first --color=auto"
fi
alias ll="ls -l"
alias dir="ll"
alias t="%"
alias j="jobs -l"
alias pd="pushd"
alias p="popd"
alias cls="clear; ls"
alias proj="cd $PROJECTS"
alias lab="cd $LAB"
alias tmux="tmux -S ~/.tmux"

# Time
export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\nmem\t%M kb'

# history
HISTFILE=~/.histfile
HISTSIZE=4096
SAVEHIST=4096
setopt APPEND_HISTORY

setopt menucomplete

# Load completions for Ruby, Git, etc.
autoload compinit
compinit
zstyle ':completion:*' menu select
setopt completealiases

export EDITOR='nvim' # all vim all the time
export CLICOLOR="YES" # all CLI colors on
if [[ $TMUX == '' ]]
then
    export TERM=xterm-256color
else
    export TERM=screen-256color
fi

# keybindings
bindkey -e
bindkey "^P" history-search-backward
bindkey "^N" history-search-forward
bindkey "^R" history-incremental-search-backward
bindkey "^[[3~" delete-char
bindkey "^[[4~" end-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# set tab title to cwd
function precmd () {
    tab_label=${PWD/${HOME}/\~} # use 'relative' path
    echo -ne "\e]2;${tab_label}\a" # set window title to full string
    echo -ne "\e]1;${tab_label: -24}\a" # set tab title to rightmost 24 characters
}

# Search history
function hs () {
    history | ag -i $1
}

# Fishy collapse of pwd
function _fishy_collapse_wd() {
    echo $(pwd | perl -pe "
        BEGIN {
            binmode STDIN, ':encoding(UTF-8)';
            binmode STDOUT, ':encoding(UTF-8)';
        }; s|^$HOME|~|g; s|/([^/])[^/]*(?=/)|/\$1|g
    ")
}

# Source Control Status Prompts
function _vcs_branch() {
    BRANCH=`git branch --no-color 2> /dev/null`
    if [[ $? -eq 0 ]]
    then
        echo " $(_vcs_git_remote)%F{green}`echo $BRANCH| ag -Q \* | awk -F'*' '{print $2}' | tr -d ' '`%f"
        return
    fi
}

function _vcs_status() {
    STAT=`git status -s --porcelain 2> /dev/null`
    if [[ $? -eq 0 ]]
    then
        if [[ `echo $STAT | wc -w | tr -d ' '` -ne 0 ]]
        then
            echo "%F{red}•%f"
            return
        else
            echo "%F{green}✓%f"
            return
        fi
    fi
}

function _vcs_git_remote() {
    git rev-parse --git-dir &> /dev/null
    if [[ $? -eq 0 ]]
    then
        BRANCH=`git branch --no-color | ag -Q \* | awk '{print $2}'`
        RSTATUS=`git rev-list --left-right origin/$BRANCH...HEAD 2> /dev/null`
        if [[ $? -ne 0 ]]; then return; fi

        if [[ `echo $RSTATUS | wc -w | tr -d ' '` -ne 0 ]]
        then
            echo "%F{yellow}*%f"
            return
        fi
    fi
}

# vi-mode stuff
#function zle-line-init zle-keymap-select {
#    RPS1="${${KEYMAP/vicmd/[NORMAL]}/(main|viins)/[INSERT]}"
#    RPS2=$RPS1
#    zle reset-prompt
#}
#zle -N zle-line-init
#zle -N zle-keymap-select

# Source a python virtualenv if one exists in the current directory
function venv() {
    source venv/bin/activate 2> /dev/null
}

# MySQL Cleartext Plugin
export LIBMYSQL_ENABLE_CLEARTEXT_PLUGIN=1

# JAVA
if [[ `uname` = "Darwin" ]]
then
    export JAVA_HOME=`/usr/libexec/java_home`
fi

# GOLANG
export GOROOT=/usr/local/Cellar/go/1.16.1/libexec
export GOPATH=$HOME/Documents/Projects/golang
PATH=$PATH:$GOROOT/bin
alias gopath="cd $GOPATH"

# LLVM
export PATH=/usr/local/opt/llvm/bin:$PATH

# FZF
export FZF_DEFAULT_COMMAND="ag -l --nocolor"
export FZF_DEFAULT_OPTS="--cycle --info=hidden +m"

# Sublime Text
export PATH=$PATH:/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/
