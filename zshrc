autoload -U colors && colors

# PATH
PATH=/usr/local/bin/:/usr/local/share/python:$PATH
export PATH

# Prompt
setopt prompt_subst
export PROMPT='%(1j.(%F{cyan}%j%F{reset}) .)[%n@%m %F{green}%.%F{reset}]\$ '
export RPROMPT='$(~/.bin/vcs-prompt/vcs-prompt.py)'

# Aliases
alias ls="ls -GF"
alias ll="ls -l"
alias grep="grep --color=auto"
alias sed="gsed"
alias emacs="emacs -nw"

# history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt APPEND_HISTORY

setopt menucomplete

# Load completions for Ruby, Git, etc.
autoload compinit
compinit
zstyle ':completion:*' menu select
setopt completealiases

export EDITOR='vim' # all vim all the time
export HISTSIZE=4096 # history
export CLICOLOR="YES" # all CLI colors on 

# keybindings
bindkey "^P" history-search-backward
bindkey "^N" history-search-forward

/Users/mhelsper/Documents/Code/archey-osx/archey
