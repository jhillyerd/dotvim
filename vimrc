" James' attempt at a multiplatform vimrc
" Note: Non-plugin specific stuff is in plugin/common.vim

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
autocmd!
filetype off

" Vim doesn't grok fish
if &shell =~# 'fish$'
  set shell=sh
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle (required)
Plugin 'gmarik/vundle'

" vimscripts plugins
Plugin 'matchit.zip'

" github plugins
Plugin 'altercation/vim-colors-solarized'
Plugin 'benmills/vimux'
Plugin 'benmills/vimux-golang'
Plugin 'bling/vim-airline'
Plugin 'dag/vim-fish'
Plugin 'ervandew/supertab'
Plugin 'fatih/vim-go'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/syntastic'
Plugin 'Shougo/unite.vim'
Plugin 'SirVer/ultisnips'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'

let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:VimuxUseNearestPane=0

" Looks
if has("gui_running")
  set lines=50 columns=120
  let g:solarized_contrast="high"
  set guioptions-=T                    "remove toolbar
else
  let g:solarized_termcolors=16
endif
set background=dark
colorscheme solarized

" Command mappings
nmap <silent> <Leader>nt :NERDTreeToggle<CR>
nmap <silent> <Leader>t :TagbarOpenAutoClose<CR>

" Unite mappings
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('buffer,file,file_rec', 'sorters', 'sorter_rank')
nnoremap <C-p> :<C-u>Unite -start-insert buffer file_rec<CR>
nmap <Leader>b :<C-u>Unite buffer<CR>

" Vimux mappings
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vt :VimuxTogglePane<CR>
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vc :VimuxClearRunnerHistory<CR>
map <Leader>vk :VimuxInterruptRunner<CR>
map <Leader>vz :VimuxZoomRunner<CR>

if has("autocmd")
  " Golang vimux mappings
  autocmd FileType go map <buffer> <Leader>ra :GolangTestCurrentPackage<CR>
  autocmd FileType go map <buffer> <Leader>rf :GolangTestFocused<CR>
  " Golang vim-go mappings
  autocmd FileType go nmap <Leader>gd <Plug>(go-doc-tab)
  autocmd FileType go nmap <leader>gt <Plug>(go-test)
endif

" Use gotags for tagbar
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
