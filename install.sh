#!/bin/bash

function main {
    set_symlinks
    install_vundle
}

function set_symlinks {
    for i in *
    do
        if [ "$i" != "$0" ]
        then
            ln -sf "`pwd`/$i" "$HOME/.$i"
        fi
    done
}

function install_vundle {
    # This is for vim
    mkdir -p vim/bundle/vundle
    pushd vim/bundle/vundle
    if [ ! -d ".git" ]
    then
        git init
        git remote add -t master origin git://github.com/gmarik/vundle.git
        git pull
        vim +PluginInstall +qa
    fi
    popd
}

main
