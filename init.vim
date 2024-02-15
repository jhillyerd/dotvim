" vimrc
" description: James' attempt at a multiplatform vim configuration
" vim:fdm=marker:ai:et:sw=2:ts=8:tw=80

" Initialization --------------------------------------------------------- {{{1
"
" Platform Detection
let g:UNIX = has('unix') && !has('macunix') && !has('win32unix')
let g:WINDOWS = (has('win32') || has('win64'))

" Leader Keys
let mapleader = " "
let maplocalleader = ","

lua require('config')

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
