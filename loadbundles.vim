" Load and configure Vundle plugins
let &runtimepath .= ',' . expand(vimDir . '/bundle/Vundle.vim')
if empty(globpath(&runtimepath, 'autoload/vundle.vim'))
  finish
endif

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
if !has("win32")
  Plugin 'benmills/vimux'
  Plugin 'benmills/vimux-golang'
  Plugin 'dag/vim-fish'
  Plugin 'majutsushi/tagbar'
  Plugin 'scrooloose/syntastic'
  Plugin 'wincent/terminus'
  Plugin 'xolox/vim-easytags'
  Plugin 'xolox/vim-misc'
  if v:version > 703
    Plugin 'SirVer/ultisnips'
  endif
endif

" All of your Plugins must be added before the following line (required)
call vundle#end()

let g:conoline_use_colorscheme_default_normal=1
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:VimuxUseNearestPane=0

" Sometimes when using both vim-go and syntastic Vim will start
" lagging while saving and opening files.  Fix:
let g:syntastic_go_checkers = ['go']
let g:syntastic_mode_map = { 'mode': 'active' }

" Tagbar
nnoremap <silent> <Leader>t :TagbarOpenAutoClose<CR>

" Airline tabline setup
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <Leader>1 <Plug>AirlineSelectTab1
nmap <Leader>2 <Plug>AirlineSelectTab2
nmap <Leader>3 <Plug>AirlineSelectTab3
nmap <Leader>4 <Plug>AirlineSelectTab4
nmap <Leader>5 <Plug>AirlineSelectTab5
nmap <Leader>6 <Plug>AirlineSelectTab6
nmap <Leader>7 <Plug>AirlineSelectTab7
nmap <Leader>8 <Plug>AirlineSelectTab8
nmap <Leader>9 <Plug>AirlineSelectTab9

" Unite mappings
if !empty(globpath(&rtp, 'autoload/unite.vim'))
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
  call unite#custom#source('buffer,file,file_rec', 'sorters', 'sorter_rank')
  nnoremap <C-p> :<C-u>Unite -start-insert buffer file_rec<CR>
  nnoremap <Leader>b :<C-u>Unite buffer<CR>
endif

" Vimux mappings
noremap <Leader>vp :VimuxPromptCommand<CR>
noremap <Leader>vl :VimuxRunLastCommand<CR>
noremap <Leader>vi :VimuxInspectRunner<CR>
noremap <Leader>vt :VimuxTogglePane<CR>
noremap <Leader>vq :VimuxCloseRunner<CR>
noremap <Leader>vc :VimuxClearRunnerHistory<CR>
noremap <Leader>vk :VimuxInterruptRunner<CR>
noremap <Leader>vz :VimuxZoomRunner<CR>

if has("autocmd")
  augroup GOLANG
    autocmd!
    " Reformat comments using vim-commentary text object
    autocmd FileType go nmap <buffer> Q gqgc
    " Golang vimux mappings
    autocmd FileType go noremap <buffer> <LocalLeader>ra :GolangTestCurrentPackage<CR>
    autocmd FileType go noremap <buffer> <LocalLeader>rf :GolangTestFocused<CR>
    " vim-go mappings that perform an action
    autocmd FileType go nmap <LocalLeader>a <Plug>(go-alternate-edit)
    autocmd FileType go nmap <LocalLeader>b <Plug>(go-build)
    autocmd FileType go nmap <LocalLeader>c <Plug>(go-coverage)
    autocmd FileType go nmap <LocalLeader>e <Plug>(go-rename)
    autocmd FileType go nmap <LocalLeader>i <Plug>(go-import)
    autocmd FileType go nmap <LocalLeader>l <Plug>(go-metalinter)
    autocmd FileType go nmap <LocalLeader>r <Plug>(go-run)
    autocmd FileType go nmap <LocalLeader>t <Plug>(go-test)
    " vim-go mappings that look up (show) something under the cursor
    autocmd FileType go nmap <LocalLeader>sd <Plug>(go-doc-tab)
    autocmd FileType go nmap <LocalLeader>si <Plug>(go-implements)
    autocmd FileType go nmap <LocalLeader>sr <Plug>(go-referrers)
  augroup END
endif
