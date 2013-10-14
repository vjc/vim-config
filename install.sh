#!/bin/bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NOW=$(date +"%Y%m%d")

if [ -e ~/.vimrc ]; then
    mv ~/.vimrc ".vimrc.backup.$NOW"
fi

if [ -e ~/.vim ]; then
    mv ~/.vim ".vim.backup.$NOW"
fi

ln -s "$DIR/.vimrc" ~/.vimrc
mkdir ~/.vim

# Install vundle
if [ ! -e ~/.vim/bundle/vundle ]; then
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi
vim +BundleInstall! +qall

