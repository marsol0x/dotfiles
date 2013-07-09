autoload -U colors && colors

# PATH
PATH=$HOME/.bin:/usr/local/bin:/usr/local/share/python:/usr/local/opt/ruby/bin:$PATH
export PATH

# Prompt
setopt prompt_subst
export PROMPT='%(1j.(%F{cyan}%j%F{reset}) .)[%n@%m %F{green}%.%F{reset}]\$ '
export RPROMPT='$(~/.bin/vcs-prompt/vcs-prompt.py)'

# Aliases
if [[ `uname` != "Darwin" ]]
then
    alias ls="ls -F --group-directories-first --color=auto"
    alias grep="grep --color=auto"
else
    alias ls="ls -FG"
    alias sed="gsed"
    alias grep="ggrep --color=auto"
fi
alias ll="ls -l"

# history
HISTFILE=~/.histfile
HISTSIZE=4096
SAVEHIST=1000
setopt APPEND_HISTORY

setopt menucomplete

# Load completions for Ruby, Git, etc.
autoload compinit
compinit
zstyle ':completion:*' menu select
setopt completealiases

export EDITOR='vim' # all vim all the time
#export HISTSIZE=4096 # history
export CLICOLOR="YES" # all CLI colors on 
export TERM=xterm-256color

# keybindings
bindkey "^P" history-search-backward
bindkey "^N" history-search-forward

# set tab title to cwd
precmd () {
    tab_label=${PWD/${HOME}/\~} # use 'relative' path
    echo -ne "\e]2;${tab_label}\a" # set window title to full string
    echo -ne "\e]1;${tab_label: -24}\a" # set tab title to rightmost 24 characters
}

# Search history
function hs () {
    history | grep -i $1
}

PATH=$PATH:/usr/local/rvm/bin # Add RVM to PATH for scripting
