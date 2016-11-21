dotvim
======

Platform agnostic, Plug enabled, Golang friendly Vim configuration

The vimrc is designed to be scalable in the sense that it will not blow up if
plugins are not installed, or if Plug is missing entirely.


## Unix Full Installation

Clone the repository:

    git clone https://github.com/jhillyerd/dotvim.git ~/.vim

Install plugins:

    cd ~/.vim
    ./install-plug.sh


## Windows Full Installion

Install [git-for-windows](https://git-for-windows.github.io/)

Open a git-bash shell, clone the repos:

    git clone https://github.com/jhillyerd/dotvim.git $HOME/vimfiles

Install plugins by right clicking on `install-plug.ps1` in `$HOME/vimfiles` 
and selecting *Run with PowerShell.*


## Basic Installation

Download or copy the following files from the dotvim repo while preserving the
directory structure:

    vimrc
    plugin/sensible.vim

Zip up these files and place them in $HOME/.vim (Unix) or $HOME/vimfiles
(Windows) on millions of computers.
