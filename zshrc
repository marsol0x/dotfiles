autoload -U colors && colors

# PATH
PATH=$HOME/.bin:/usr/local/bin:/usr/local/opt/ruby/bin:/usr/local/rvm/bin:$PATH
export PATH

# Prompt
setopt prompt_subst
export PROMPT='[%F{green}%T%f] %(1j.(%F{cyan}%j%F{reset}) .)$(_fishy_collapse_wd) {$(_vcs_status)} [$(_vcs_branch)$(_vcs_git_remote)]%(!.$F{red}#%f.%F{blue}\$%f) '

# Aliases
if [[ `uname` != "Darwin" ]]
then
    alias ls="ls -F --group-directories-first --color=auto"
    alias grep="grep --color=auto"
else
    alias ls="gls -F --group-directories-first --color=auto"
    alias sed="gsed"
    alias grep="ggrep --color=auto"
fi
alias ls="gls -F --group-directories-first --color=auto"
alias ll="ls -l"

eval `gdircolors /Users/mhelsper/Documents/Themes/dircolors-solarized-git/dircolors.ansi-dark`

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

export EDITOR='vim' # all vim all the time
export CLICOLOR="YES" # all CLI colors on 
if [[ $TMUX == '' ]]
then
    export TERM=xterm-256color
else
    export TERM=screen-256color
fi

# keybindings
bindkey -v
bindkey "^P" history-search-backward
bindkey "^N" history-search-forward
bindkey "^R" history-incremental-search-backward

# set tab title to cwd
function precmd () {
    tab_label=${PWD/${HOME}/\~} # use 'relative' path
    echo -ne "\e]2;${tab_label}\a" # set window title to full string
    echo -ne "\e]1;${tab_label: -24}\a" # set tab title to rightmost 24 characters
}

# Search history
function hs () {
    history | grep -i $1
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
        echo "%F{green}`echo $BRANCH| grep -i \* | awk -F'*' '{print $2}' | tr -d ' '`%f"
        return
    fi

    BRANCH=`hg branch 2> /dev/null`
    if [[ $? -eq 0 ]]
    then
        echo "%F{cyan}$BRANCH%f"
        return
    fi

    echo '%F{magenta}-%f'
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

    STAT=`hg status 2> /dev/null`
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

    echo '%F{magenta}-%f'
}

function _vcs_git_remote() {
    git rev-parse --git-dir &> /dev/null
    if [[ $? -eq 0 ]]
    then
        BRANCH=`git branch --no-color | grep \* | awk '{print $2}'`
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
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
