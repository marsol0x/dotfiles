autoload -U colors && colors

# PATH
export PATH=$HOME/.bin:/usr/local/sbin:/usr/local/bin:$PATH

# Prompt
setopt prompt_subst
export PROMPT='%F{red}$(_ssh_prompt)%F{reset}%(1j.(%F{cyan}%j%F{reset}) .)$(_fishy_collapse_wd)$(_vcs_branch)$(_vcs_status) %(!.$F{red}#%f.%F{blue}\$%f) '

# Dircolors
if [[ `uname` = "Darwin" ]]
then
    eval `gdircolors ~/.dircolors`
else
    eval `dircolors ~/.dircolors`
fi

# Aliases
if [[ `uname` = "Darwin" ]]
then
    alias sed="gsed"
    alias grep="ggrep --color=auto"
    alias ls="gls -F --group-directories-first --color=auto"
else
    alias grep="grep --color=auto"
    alias ls="ls -F --group-directories-first --color=auto"
fi
alias ll="ls -l"

# Aliases
alias t="%"
alias j="jobs"
alias pd="pushd"
alias p="popd"
alias cls="clear; ls"
alias proj="cd ~/Documents/Projects"
alias lab="cd ~/Documents/Lab"


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

# Display hostname if I'm ssh'd in
function _ssh_prompt() {
    if [ -n "${SSH_TTY+x}" ]
    then
        echo "`hostname -s` "
    fi
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
        echo " $(_vcs_git_remote)%F{green}`echo $BRANCH| grep -i \* | awk -F'*' '{print $2}' | tr -d ' '`%f"
        return
    fi

    BRANCH=`hg branch 2> /dev/null`
    if [[ $? -eq 0 ]]
    then
        echo " [%F{cyan}$BRANCH%f]"
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
    RPS1="${${KEYMAP/vicmd/[NORMAL]}/(main|viins)/[INSERT]}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Source a python virtualenv if one exists in the current directory
function venv {
    source venv/bin/activate 2> /dev/null
}

# My own todo command
function todo {
    todo_jar=~/Documents/Projects/todotxt/dist/TodoTxt.jar
    if [[ -e "$todo_jar" ]]
    then
        java -jar $todo_jar $*
    fi
}


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# MySQL Cleartext Plugin
export LIBMYSQL_ENABLE_CLEARTEXT_PLUGIN=1

# JAVA
if [[ `uname` = "Darwin" ]]
then
    export JAVA_HOME=`/usr/libexec/java_home`
fi
