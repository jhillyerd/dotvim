" James' attempt at a multiplatform vimrc
" Note: Non-plugin specific stuff is in plugin/common.vim

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
autocmd!
filetype off

let g:win_shell = (has('win32') || has('win64')) && &shellcmdflag =~ '/'
let g:vimDir = g:win_shell ? '$HOME/vimfiles' : '$HOME/.vim'

" loadbundles.vim loads and configures our plugins (optional)
runtime loadbundles.vim

" Post-plugin init
filetype plugin indent on

" Options (many more set in vim-sensible)
set completeopt=menu,longest           " Popup a menu for completion
set expandtab                          " Uses spaces for indent
set fillchars=vert:\|,fold:\           " Visual fill characters
set foldmethod=syntax                  " Fold based on file's syntax
set foldnestmax=1                      " I prefer one level of folds
set nofoldenable                       " But folds are mostly annoying
set hidden                             " Allow hidden buffers
set hlsearch                           " Highlight search hits
set number                             " Always display line numbers
set shiftwidth=2                       " Number of spaces for autoindent
set showcmd                            " Show partial commands, areas
set showmatch                          " Highlight matching (){}[]
set wildmode=longest,list,full         " Command line completion options

if exists('+colorcolumn')
  set colorcolumn=100
endif

" vim-sensible calls this, but it doesn't seem to work for 7.2
syntax enable

let mapleader="\\"
let maplocalleader=","

" netrw should never be my alternate file
let g:netrw_altfile=1

" Looks
if has("gui_running")
  set lines=50 columns=120
  let g:solarized_contrast="high"
  set guioptions-=T " Remove toolbar

  if has("win32")
    set guifont=Consolas:h11
    set guioptions-=L " Prevent window resizing
  else
    if has("gui_gtk2")
      set guifont=Inconsolata\ Medium\ 11
    else
      " Assume OS X
      set guifont=Monaco:h13
    endif
  endif
else
  " Running in terminal
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
nnoremap <leader>sv :source $MYVIMRC<cr>

" N,V,O mappings
noremap Q gqip
noremap Y y$

" Command mappings
nnoremap <silent> <Leader>l :set list!<CR>
nnoremap <silent> <Leader>n :call ToggleNumber()<CR>
nnoremap <silent> <Leader>p :set paste!<CR>
nnoremap <silent> <Leader>q :call ToggleQFix()<CR>
nnoremap <silent> <Leader>w :set columns=180<CR>
nnoremap <silent> + :resize +2<CR>
nnoremap <silent> _ :resize -2<CR>

" Use cursor keys to navigate in/out of tags
nnoremap <Left> <C-T>
nnoremap <Right> <C-]>

" Toggle folds with spacebar
nnoremap <Space> za

" Place cursor at start of . command
nnoremap . .`[

" Insert mappings
inoremap `jh James Hillyerd
inoremap `em james@hillyerd.com

if has("autocmd")
  augroup VIMRC
    autocmd!
    " Quickfix window
    autocmd QuickFixCmdPre * :update
    autocmd QuickFixCmdPost * :cwindow
    " Recognize .md as markdown, not modula2
    autocmd BufRead,BufNewFile *.md set filetype=markdown
  augroup END
endif

" Toggle the quickfix window
function! ToggleQFix()
  for i in range(1, winnr('$'))
    if getbufvar(winbufnr(i), '&buftype') == 'quickfix'
      cclose
      return
    endif
  endfor
  copen
endfunction

" Toggle number and disable mouse for copying from terminal
function! ToggleNumber()
  if &number
    set nonumber
    if !has("gui_running")
      let s:mouse_opts=&mouse
      set mouse=
    endif
  else
    set number
    if !has("gui_running")
      execute "set mouse=" . s:mouse_opts
    endif
  endif
endfunction

" Better looking folds
function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()

" Prose mode
" From http://alols.github.io/2012/11/07/writing-prose-with-vim/
function! SetProse()
  " Break undo sequence at the end of sentences
  inoremap <buffer> . .<C-G>u
  inoremap <buffer> ! !<C-G>u
  inoremap <buffer> ? ?<C-G>u
  setlocal spell spelllang=en nolist nowrap textwidth=74 formatoptions=t1
  " Only auto-format during insert mode
  augroup PROSE
    autocmd!
    autocmd InsertEnter <buffer> set formatoptions+=a
    autocmd InsertLeave <buffer> set formatoptions-=a
  augroup END
  " Fix previous typo, return to cursor
  nnoremap <silent> <buffer> <LocalLeader>f :normal! mm[s1z=`m<CR>
endfunction
command! Prose call SetProse()

" Reformat document: soft wrap paragraphs
" - Add a blank line to end of document
" - Join all non-blank lines
" - Remove trailing whitespace
" - Double-space
command! -range=% SoftWrap
      \ <line2>put _ |
      \ silent <line1>,<line2>g/\S/,/^\s*$/join | silent s/\s\+$// | put _
