" James' attempt at a multiplatform vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
autocmd!
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle (required)
Bundle 'gmarik/vundle'

" vimscripts plugins
Bundle 'bufexplorer.zip'
Bundle 'matchit.zip'

" github plugins
Bundle 'altercation/vim-colors-solarized'
Bundle 'bling/vim-airline'
Bundle 'ervandew/supertab'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
"Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'SirVer/ultisnips'
Bundle 'tpope/vim-fugitive'
Bundle 'xolox/vim-easytags'
Bundle 'xolox/vim-misc'

let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:syntastic_go_checker = 'gofmt'

"Options
set autoindent                         " Copy indent from previous line
set backspace=indent,eol,start         " Allow backspacing over everything
set completeopt=menu,longest           " Popup a menu for completion
set cursorline                         " Highlight the line the cursor is on
set hidden                             " Allow hidden buffers
set hlsearch                           " Highlight search hits
set incsearch                          " Incremental search
set laststatus=2                       " Always display a status line
set number                             " Always display line numbers
set ruler                              " Always display cursor row, col
set shiftwidth=2                       " Number of spaces for autoindent
set showcmd                            " Show commands as they are typed
set smarttab                           " <Tab> uses shiftwidth at BOL
set wildmode=longest,list,full         " Command line completion options
set wildmenu                           " Display completion options

if exists('+colorcolumn')
  set colorcolumn=100
endif

let mapleader="\\"
filetype plugin indent on
syntax enable

"Looks
if has("gui_running")
  set lines=50 columns=120
  let g:solarized_contrast="high"
  set guioptions-=T                    "remove toolbar
else
  let g:solarized_termcolors=16
endif
set background=dark
colorscheme solarized

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
nmap <silent> <Leader>h :nohlsearch<CR>
nmap <silent> <Leader>n :set number!<CR>
nmap <silent> <Leader>nt :NERDTreeToggle<CR>
nmap <silent> <Leader>p :set paste!<CR>
nmap <silent> <Leader>t :TagbarOpenAutoClose<CR>
nmap <silent> <Leader>w :set columns=180<CR>
nmap <silent> + :resize +2<CR>
nmap <silent> _ :resize -2<CR>
nmap <Left> <C-T>
nmap <Right> <C-]>
map Q gq

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

"Ruby ScreenShell mappings
autocmd FileType ruby nmap <buffer> <Leader>ss :ScreenShell<CR>
autocmd FileType ruby nmap <buffer> <Leader>sr :ScreenShell irb<CR>
autocmd FileType ruby nmap <buffer> <Leader>sq :ScreenQuit<CR>
autocmd FileType ruby nmap <buffer> <Leader>ef :ScreenSend<CR>
autocmd FileType ruby nmap <buffer> <Leader>ep vip:ScreenSend<CR>
autocmd FileType ruby nmap <buffer> <Leader>el V:ScreenSend<CR>
autocmd FileType ruby vmap <buffer> <Leader>eb :ScreenSend<CR>

"Quickfix window
autocmd QuickFixCmdPre * :update
autocmd QuickFixCmdPost * :cwindow

" Auto format golang on save
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Recognize .md as markdown, not modula2
autocmd BufRead,BufNewFile *.md set filetype=markdown

"Use gotags for tagbar
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }
