" This vimrc doesn't use any plugins besides vim sensible and my common.vim

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
autocmd!
filetype off

"Looks
if has("gui_running")
  set lines=50 columns=120
  set guioptions-=T                    "remove toolbar
endif
set background=dark
colorscheme desert
