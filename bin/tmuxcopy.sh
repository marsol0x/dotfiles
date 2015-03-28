#!/bin/bash

if [[ `uname` == "Darwin" ]]
then
    tmux save-buffer - | reattach-to-user-namespace pbcopy > /dev/null
else
    tmux save-buffer - | xsel -ib
fi
