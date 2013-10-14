" James' attempt at a multiplatform vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
autocmd!
filetype off

set rtp+=~/.vim/bundle/vundle/
set rtp+=$GOROOT/misc/vim
call vundle#rc()

" let Vundle manage Vundle (required)
Bundle 'gmarik/vundle'

" vimscripts plugins
Bundle 'bufexplorer.zip'
Bundle 'matchit.zip'

" github plugins
Bundle 'altercation/vim-colors-solarized'
Bundle 'benmills/vimux'
Bundle 'benmills/vimux-golang'
Bundle 'bling/vim-airline'
Bundle 'ervandew/supertab'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
"Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'SirVer/ultisnips'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'
Bundle 'xolox/vim-easytags'
Bundle 'xolox/vim-misc'

let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"Options (many more set in vim-sensible)
set completeopt=menu,longest           " Popup a menu for completion
set cursorline                         " Highlight the line the cursor is on
set fillchars=vert:\|,fold:\           " Visual fill characters
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
nmap <silent> <Leader>n :set number!<CR>
nmap <silent> <Leader>nt :NERDTreeToggle<CR>
nmap <silent> <Leader>p :set paste!<CR>
nmap <silent> <Leader>t :TagbarOpenAutoClose<CR>
nmap <silent> <Leader>w :set columns=180<CR>
nmap <silent> + :resize +2<CR>
nmap <silent> _ :resize -2<CR>

"Use cursor keys to navigate tags
nmap <Left> <C-T>
nmap <Right> <C-]>

map Q gq
nnoremap <Space> za

"Vimux mappings
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vc :VimuxClearRunnerHistory<CR>

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

  "Golang vimux mappings
  autocmd FileType go map <buffer> <Leader>ra :GolangTestCurrentPackage<CR>
  autocmd FileType go map <buffer> <Leader>rf :GolangTestFocused<CR>

  "Quickfix window
  autocmd QuickFixCmdPre * :update
  autocmd QuickFixCmdPost * :cwindow

  " Recognize .md as markdown, not modula2
  autocmd BufRead,BufNewFile *.md set filetype=markdown
endif

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

