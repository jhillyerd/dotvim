dotvim
======

Platform agnostic, Vundle enabled, Golang friendly Vim configuration

## Unix Full Installation

Clone the repository:

    git clone https://github.com/jhillyerd/dotvim.git ~/.vim

Install bundles:

    cd ~/.vim
    ./init-vundle.sh

## Windows Full Installion

Install [git-for-windows](https://git-for-windows.github.io/)

Open a git-bash shell, clone the repos:

    git clone https://github.com/jhillyerd/dotvim.git $HOME/vimfiles
    git clone https://github.com/gmarik/Vundle.vim.git $HOME/vimfiles/bundle/Vundle.vim

Launch `gvim.exe` (ignore errors), then install the bundles:

    :PluginInstall
    :qall

## Basic Installation

Download or copy the following files from the dotvim repo while preserving the directory
structure:

    basic.vim
    plugin/common.vim
    plugin/sensible.vim

Rename `basic.vim` to `vimrc`

Zip up these files and place them in $HOME/.vim (Unix) or $HOME/vimfiles (Windows) on
millions of computers.
