" James' attempt at a paired down multiplatform vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
autocmd!
filetype off

" sensible.vim - Defaults everyone can agree on
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.0

if exists('g:loaded_sensible') || &compatible
  finish
else
  let g:loaded_sensible = 1
endif

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Use :help 'option' to see the documentation for the given option.

set autoindent
set backspace=indent,eol,start
set complete-=i
set showmatch
set smarttab

set nrformats-=octal
set shiftround

set ttimeout
set ttimeoutlen=50

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

set laststatus=2
set ruler
set showcmd
set wildmenu

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if !has('win32') && (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')
    let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"
  endif
endif

if &shell =~# 'fish$'
  set shell=/bin/bash
endif

set autoread
set fileformats+=mac

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

inoremap <C-U> <C-G>u<C-U>

" vim:set ft=vim et sw=2:
" END of vim-sensible

"Options (many more set in vim-sensible)
set completeopt=menu,longest           " Popup a menu for completion
set cursorline                         " Highlight the line the cursor is on
set foldmethod=syntax                  " Fold based on file's syntax
set foldnestmax=1                      " I prefer one level of folds
set hidden                             " Allow hidden buffers
set hlsearch                           " Highlight search hits
set number                             " Always display line numbers
set shiftwidth=2                       " Number of spaces for autoindent
set wildmode=longest,list,full         " Command line completion options

if exists('+colorcolumn')
  set colorcolumn=100
endif

"vim-sensible calls this, but it doesn't seem to work for 7.2
syntax enable

let mapleader="\\"

"Looks
if has("gui_running")
  set lines=50 columns=120
  set guioptions-=T                    "remove toolbar
endif
set background=dark
colorscheme desert

if has("win32")
  set guifont=Consolas:h11
  set guioptions-=L                    "prevent window resizing
else
  if has("gui_gtk2")
    set guifont=Inconsolata\ Medium\ 11
  else
    set guifont=Monaco:h13
  endif
endif

"Command mappings
nmap <silent> <Leader>n :set number!<CR>
nmap <silent> <Leader>p :set paste!<CR>
nmap <silent> <Leader>w :set columns=180<CR>
nmap <silent> + :resize +2<CR>
nmap <silent> _ :resize -2<CR>
nmap <Left> <C-T>
nmap <Right> <C-]>
map Q gq
nnoremap <Space> za

"Enter directory listing for the directory of the current buffer
map <leader>. :e %:p:h<CR>

"Place cursor at start of . command
nmap . .`[

"Insert mappings
imap `jh James Hillyerd
imap `em james@hillyerd.com

"Visual mappings
vmap < <gv
vmap > >gv

if has("autocmd")
  "Reload vimrc after save
  autocmd bufwritepost .vimrc source $MYVIMRC

  "Quickfix window
  autocmd QuickFixCmdPre * :update
  autocmd QuickFixCmdPost * :cwindow

  " Recognize .md as markdown, not modula2
  autocmd BufRead,BufNewFile *.md set filetype=markdown
endif

