" James' attempt at a multiplatform vimrc

runtime bundle/pathogen/autoload/pathogen.vim

autocmd!
filetype off

call pathogen#runtime_append_all_bundles()
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:syntastic_go_checker = 'gofmt'

"Options
set autoindent
set completeopt=menu,longest
set cursorline
set hidden
set hlsearch
set incsearch
set laststatus=2
set number
set ruler
set shiftwidth=2
set showcmd
set smarttab
set wildmode=longest,list,full
set wildmenu

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
  set guioptions-=T  "remove toolbar
else
  let g:solarized_termcolors=16
endif
set background=dark
colorscheme solarized
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

if has("win32")
  set guifont=Consolas:h11
else
  set guifont=Monaco:h13
endif

"Commands
command Wide :set columns=180

"Command mappings
nmap <silent> <Leader>/ :nohlsearch<CR>
nmap <Leader>nt :NERDTreeToggle<CR>
nmap <Leader>t :TagbarOpenAutoClose<CR>
nmap <silent> + :resize +2<CR>
nmap <silent> _ :resize -2<CR>
map 0 ^
nmap <Left> <C-T>
nmap <Right> <C-]>
nnoremap Q gq

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
