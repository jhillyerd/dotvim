" James' attempt at a multiplatform vimrc

autocmd!
filetype off

"Options
set autoindent
set colorcolumn=100
set completeopt=menu,longest
set cursorline
set hidden
set hlsearch
set incsearch
set laststatus=2
set relativenumber
set ruler
set shiftwidth=2
set showcmd
set smarttab
set wildmode=longest,list,full
set wildmenu

let mapleader="\\"
filetype plugin indent on
syntax enable

"Looks
if has("gui_running")
  set lines=50 columns=120
  set guioptions-=T  "remove toolbar
endif
set background=dark
colorscheme desert

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
nmap <silent> + :resize +2<CR>
nmap <silent> _ :resize -2<CR>
map 0 ^
nmap <Left> <C-T>
nmap <Right> <C-]>

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

"Quickfix window
autocmd QuickFixCmdPre * :update
autocmd QuickFixCmdPost * :cwindow

