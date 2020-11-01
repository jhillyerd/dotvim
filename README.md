dotvim
======

Platform agnostic, Plug enabled, Neovim configuration

`init.vim` is designed to be scalable, in the sense that it will not blow up if
plugins are not installed, or if Plug is missing entirely.


## Unix Full Installation

Clone the repository:

    git clone https://github.com/jhillyerd/dotvim.git ~/.config/nvim

Install plugins:

    cd ~/.config/nvim
    ./install-plug


## Windows Full Installation

(need to update for neovim)

Install [git-for-windows](https://git-for-windows.github.io/)

Open a git-bash shell, clone the repos:

    git clone https://github.com/jhillyerd/dotvim.git $HOME/vimfiles

Install plugins by right clicking on `install-plug.ps1` in `$HOME/vimfiles` 
and selecting *Run with PowerShell.*
