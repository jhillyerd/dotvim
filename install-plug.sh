#!/bin/sh
if [ $MSYSTEM ]; then
  # Windows Git Bash
  vimdir="$HOME/vimfiles"
  vimbin="gvim.exe"
else
  vimdir="$HOME/.vim"
  vimbin="vim"
fi

curl -fLo "$vimdir/autoload/plug.vim" --create-dirs \
  "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

$vimbin +PlugInstall +qall
