" James' attempt at a multiplatform vimrc
" Note: Non-plugin specific stuff is in plugin/common.vim

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
autocmd!
filetype off

" Vim doesn't grok fish
if &shell =~# 'fish$'
  set shell=sh
endif

let win_shell = (has('win32') || has('win64')) && &shellcmdflag =~ '/'
let vimDir = win_shell ? '$HOME/vimfiles' : '$HOME/.vim'

" loadbundles.vim loads and configures our plugins (optional)
runtime loadbundles.vim

" Post-plugin init
filetype plugin indent on 

" Looks
if has("gui_running")
  set lines=50 columns=120
  let g:solarized_contrast="high"
  set guioptions-=T "remove toolbar
else
  let g:solarized_termcolors=16
endif
set background=dark

" Solarize colors if available
if !empty(globpath(&rtp, 'colors/solarized.vim'))
  colorscheme solarized
else
  colorscheme desert
endif

" Command mappings
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>ec :execute "edit" expand(g:vimDir . "/plugin/common.vim")<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
