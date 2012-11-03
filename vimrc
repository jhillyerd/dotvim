" James' attempt at a multiplatform vimrc

if has("win32")
  source $VIM/_vimrc
  let &runtimepath=substitute(&runtimepath, "jamehi03/vimfiles", "jamehi03/.vim", "g")
endif

runtime bundle/pathogen/autoload/pathogen.vim

autocmd!
filetype off

call pathogen#runtime_append_all_bundles() 
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

"Options
set autoindent
set completeopt=menu,longest
set shiftwidth=2
set smarttab
set ruler
set laststatus=2
set showcmd
set hidden
set hlsearch
set incsearch
set number
set relativenumber
set wildmode=longest,list,full
set wildmenu
let mapleader="\\"
filetype plugin indent on
syntax enable

"Looks
if has("gui_running")
  set lines=50 columns=120
  let g:solarized_contrast="high"
  set guioptions-=T  "remove toolbar
else
  let g:solarized_termcolors=16
endif
autocmd InsertEnter * setlocal cursorline
autocmd InsertLeave * setlocal nocursorline
set background=dark
colorscheme solarized
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

if has("win32")
  set guifont=Consolas:h11
  set selectmode=""
else
  set guifont=Monaco:h13
endif

"Commands
command Wide :set columns=180

"Command mappings
nmap <silent> <Leader>/ :nohlsearch<CR>
nmap <Leader>nt :NERDTreeToggle<CR>
nmap <silent> + :resize +2<CR>
nmap <silent> _ :resize -2<CR>
map 0 ^

"Trying these out
nmap <Left> <C-T>
nmap <Right> <C-]>

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
