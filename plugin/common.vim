" Common code between my full and basic vimrc files

"Options (many more set in vim-sensible)
set completeopt=menu,longest           " Popup a menu for completion
set cursorline                         " Highlight the line the cursor is on
set fillchars=vert:\|,fold:\           " Visual fill characters
set foldmethod=syntax                  " Fold based on file's syntax
set foldnestmax=1                      " I prefer one level of folds
set hidden                             " Allow hidden buffers
set hlsearch                           " Highlight search hits
set expandtab                          " Uses spaces for indent
set number                             " Always display line numbers
set shiftwidth=2                       " Number of spaces for autoindent
set wildmode=longest,list,full         " Command line completion options

if exists('+colorcolumn')
  set colorcolumn=100
endif

"vim-sensible calls this, but it doesn't seem to work for 7.2
syntax enable

let mapleader="\\"

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

"N,V,O mappings
map Q gqap
map Y y$

"Command mappings
nmap <silent> <Leader>l :set list!<CR>
nmap <silent> <Leader>n :set number!<CR>
nmap <silent> <Leader>p :set paste!<CR>
nmap <silent> <Leader>w :set columns=180<CR>
nmap <silent> + :resize +2<CR>
nmap <silent> _ :resize -2<CR>

"Use cursor keys to navigate tags
nmap <Left> <C-T>
nmap <Right> <C-]>

nnoremap <Space> za

"Place cursor at start of . command
nmap . .`[

"Insert mappings
imap `jh James Hillyerd
imap `em james@hillyerd.com

if has("autocmd")
  "Reload vimrc after save
  autocmd bufwritepost vimrc source $MYVIMRC
  autocmd bufwritepost .vimrc source $MYVIMRC

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

" Prose mode
" From http://alols.github.io/2012/11/07/writing-prose-with-vim/
command! Prose inoremap <buffer> . .<C-G>u|
      \ inoremap <buffer> ! !<C-G>u|
      \ inoremap <buffer> ? ?<C-G>u|
      \ setlocal spell spelllang=en
      \     nolist nowrap tw=74 fo=t1 |
      \ augroup PROSE|
      \   autocmd InsertEnter <buffer> set fo+=a|
      \   autocmd InsertLeave <buffer> set fo-=a|
      \ augroup END

" Reformat document: soft wrap paragraphs
" From http://alols.github.io/2012/11/07/writing-prose-with-vim/
command! -range=% SoftWrap
      \ <line2>put _ |
      \ <line1>,<line2>g/.\+/ .;-/^$/ join |normal $x
