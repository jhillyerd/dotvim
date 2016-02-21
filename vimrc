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

let win_shell = (has('win32') || has('win64')) && &shellcmdflag =~ '/'
let vimDir = win_shell ? '$HOME/vimfiles' : '$HOME/.vim'
let &runtimepath .= ',' . expand(vimDir . '/bundle/Vundle.vim')
call vundle#begin(expand(vimDir . '/bundle'))

" let Vundle manage Vundle (required)
Plugin 'gmarik/Vundle.vim'

" vimscripts plugins
Plugin 'matchit.zip'

" github plugins, windows friendly
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ervandew/supertab'
Plugin 'fatih/vim-go'
Plugin 'miyakogi/conoline.vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'
if v:version > 702
  Plugin 'Shougo/unite.vim'
endif

" github plugs, unix preferred
if !win_shell
  Plugin 'benmills/vimux'
  Plugin 'benmills/vimux-golang'
  Plugin 'dag/vim-fish'
  Plugin 'majutsushi/tagbar'
  Plugin 'scrooloose/syntastic'
  Plugin 'xolox/vim-easytags'
  Plugin 'xolox/vim-misc'
  if v:version > 703
    Plugin 'SirVer/ultisnips'
  endif
endif

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let g:conoline_use_colorscheme_default_normal=1
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:VimuxUseNearestPane=0

" Sometimes when using both vim-go and syntastic Vim will start
" lagging while saving and opening files.  Fix:
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

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
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>ec :execute "edit" expand(g:vimDir . "/plugin/common.vim")<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nmap <silent> <Leader>t :TagbarOpenAutoClose<CR>

" Unite mappings
if v:version > 702
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
  call unite#custom#source('buffer,file,file_rec', 'sorters', 'sorter_rank')
  nnoremap <C-p> :<C-u>Unite -start-insert buffer file_rec<CR>
  nmap <Leader>b :<C-u>Unite buffer<CR>
endif

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
  autocmd FileType go nmap <LocalLeader>a <Plug>(go-alternate-edit)
  autocmd FileType go nmap <LocalLeader>b <Plug>(go-build)
  autocmd FileType go nmap <LocalLeader>c <Plug>(go-coverage)
  autocmd FileType go nmap <LocalLeader>d <Plug>(go-doc-tab)
  autocmd FileType go nmap <LocalLeader>e <Plug>(go-rename)
  autocmd FileType go nmap <LocalLeader>i <Plug>(go-import)
  autocmd FileType go nmap <LocalLeader>l <Plug>(go-metalinter)
  autocmd FileType go nmap <LocalLeader>r <Plug>(go-run)
  autocmd FileType go nmap <silent> <LocalLeader>s :SyntasticCheck<CR>:Errors<CR>
  autocmd FileType go nmap <LocalLeader>t <Plug>(go-test)
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
