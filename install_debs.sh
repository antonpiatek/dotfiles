#!/bin/bash
set -e

# Installer for my favourite deb packages (or at least a list of things I nearly always want to install)

DEBS=$(cat <<END| tr '\n' ' '
    atop
    byobu
    etckeeper
    git
    todotxt-cli
    mosh
    vim-tiny
END
)

for i in $DEBS
do
    if ! dpkg -s "$i" > /dev/null 2>&1
    then
        echo "$i not installed, installing via apt"
        sudo apt install $i
    else
        echo "$i installed already"
    fi
done
