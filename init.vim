" vimrc
" description: James' attempt at a multiplatform vim configuration
" vim:fdm=marker:ai:et:sw=2:ts=8:tw=80

" Initialization --------------------------------------------------------- {{{1
"
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
autocmd!
filetype off

" Platform Detection
let g:UNIX = has('unix') && !has('macunix') && !has('win32unix')
let g:WINDOWS = (has('win32') || has('win64'))

" Leader Keys
let mapleader = " "
let maplocalleader = ","

lua require('config')

" Post-plugin init
filetype plugin indent on

" Plugin Configuration --------------------------------------------------- {{{1
"
" Conoline Configuration
let g:conoline_use_colorscheme_default_normal=1

" netrw should never be my alternate file
let g:netrw_altfile=1

" Commands --------------------------------------------------------------- {{{1
"
command! Here :cd %:p:h

" Language: Markdown ----------------------------------------------------- {{{1
"
if has("autocmd")
  let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'sh']
endif

" Reformat document: soft wrap paragraphs
" - Add a blank line to end of document
" - Join all non-blank lines
" - Remove trailing whitespace
" - Double-space
command! -range=% SoftWrap
      \ <line2>put _ |
      \ silent <line1>,<line2>g/\S/,/^\s*$/join | silent s/\s\+$// | put _
