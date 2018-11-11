#!/usr/bin/env bash

set -eo pipefail

vimdir="$HOME/.vim"

mkdir -p "$vimdir/autoload"
curl -fLo "$vimdir/autoload/plug.vim" \
  "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

vim +PlugInstall +qall
