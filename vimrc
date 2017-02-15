" vimrc
" description: James' attempt at a multiplatform vim configuration
" vim:fdm=marker:ai:et:sw=2:ts=8:tw=80

" Initialization --------------------------------------------------------- {{{1
"
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
autocmd!
filetype off

" Platform Detection
let g:OSX = has('macunix')
let g:UNIX = has('unix') && !has('macunix') && !has('win32unix')
let g:WINDOWS = (has('win32') || has('win64'))
let g:POSIX = !(g:WINDOWS && &shellcmdflag =~ '/')
let g:GOOGLE = g:UNIX && filereadable('/usr/share/vim/google/google.vim')
let g:vim_dir = g:POSIX ? '$HOME/.vim' : '$HOME/vimfiles'

" Google Init ------------------------------------------------------------ {{{1
if g:GOOGLE
  source /usr/share/vim/google/google.vim
end

" Plug List -------------------------------------------------------------- {{{1
"
" Detect Plug
if !empty(globpath(&runtimepath, 'autoload/plug.vim'))
  call plug#begin(expand(vim_dir . '/plugged'))

  " vimscripts plugins
  Plug 'matchit.zip'

  " github plugins, windows friendly
  Plug 'vim-airline/vim-airline'
  Plug 'ervandew/supertab'
  Plug 'fatih/vim-go', { 'for': 'go' }
  Plug 'miyakogi/conoline.vim'
  Plug 'romainl/Apprentice'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-vinegar'
  if v:version > 702
    Plug 'Shougo/unite.vim'
  endif

  " github plugs, unix preferred
  if !g:WINDOWS
    Plug 'airblade/vim-gitgutter'
    Plug 'benmills/vimux'
    Plug 'benmills/vimux-golang'
    Plug 'dag/vim-fish', { 'for': 'fish' }
    Plug 'majutsushi/tagbar'
    Plug 'scrooloose/syntastic'
    Plug 'wincent/terminus'
    Plug 'xolox/vim-misc'
    if v:version > 703
      Plug 'SirVer/ultisnips'
    endif
    if !g:GOOGLE
      Plug 'xolox/vim-easytags'
    end
  endif

  " All of your Plugins must be added before the following line (required)
  call plug#end()
endif

" Glug Plugins ----------------------------------------------------------- {{{1
if g:GOOGLE
  Glug blaze plugin[mappings]='<LocalLeader>b'
  Glug syntastic-google
end

" Post-plugin init (not Vundle dependent)
filetype plugin indent on

" Plugin Configuration --------------------------------------------------- {{{1
"
" Airline Configuration
if !empty(globpath(&runtimepath, 'autoload/airline.vim'))
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
endif

if g:GOOGLE
  " Blaze Configuration
  let g:blazevim_quickfix_autoopen = 1
  let g:blazevim_ignore_warnings = 0
  Glaive blaze show_warnings use_external_parser
endif

" Conoline Configuration
let g:conoline_use_colorscheme_default_normal=1

" Fugitive Configuration
nnoremap <Leader>ga :<C-u>Gwrite<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gs :<C-u>Gstatus<CR>

" SuperTab Configuration
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" Syntastic Configuration
" Sometimes when using both vim-go and syntastic Vim will start
" lagging while saving and opening files.  Fix:
let g:syntastic_go_checkers = ['go']
let g:syntastic_mode_map = { 'mode': 'active' }
if g:GOOGLE
  " Google specific linting
  let g:syntastic_javascript_checkers = ['gjslint']
  let g:syntastic_javascript_gjslint_args = '--jslint_error=all'
  let g:syntastic_python_checkers = ['gpylint']
endif

" Tagbar Configuration
nnoremap <silent> <Leader>t :<C-u>TagbarOpenAutoClose<CR>

" UltiSnips Configuration
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Unite Configuration
if !empty(globpath(&runtimepath, 'autoload/unite.vim'))
  "call unite#custom#source('buffer,file,file_rec', 'matchers', 'matcher_fuzzy')
  call unite#custom#source('buffer,file,file_rec', 'sorters', 'sorter_rank')
  nnoremap <C-p> :<C-u>Unite -start-insert file_rec<CR>
  nnoremap <Leader>b :<C-u>Unite buffer<CR>
  nnoremap <Leader>/ :<C-u>Unite -start-insert line:buffers<CR>
  function! s:unite_my_settings()
    inoremap <silent><buffer><expr> <C-s>
          \ unite#smart_map('<C-s>', unite#do_action('split'))
    inoremap <silent><buffer><expr> <C-v>
          \ unite#smart_map('<C-v>', unite#do_action('vsplit'))
  endfunction
  augroup UniteMaps
    autocmd!
    autocmd FileType unite call s:unite_my_settings()
  augroup END
endif

" Vimux Configuration
if !empty(globpath(&runtimepath, 'plugin/vimux.vim'))
  function! VimuxSlime()
    call VimuxSendText(@v)
    call VimuxSendKeys("Enter")
  endfunction

  let g:VimuxUseNearestPane=0
  noremap <Leader>vp :<C-u>VimuxPromptCommand<CR>
  noremap <Leader>vl :<C-u>VimuxRunLastCommand<CR>
  noremap <Leader>vi :<C-u>VimuxInspectRunner<CR>
  noremap <Leader>vt :<C-u>VimuxTogglePane<CR>
  noremap <Leader>vq :<C-u>VimuxCloseRunner<CR>
  noremap <Leader>vc :<C-u>VimuxClearRunnerHistory<CR>
  noremap <Leader>vk :<C-u>VimuxInterruptRunner<CR>
  noremap <Leader>vz :<C-u>VimuxZoomRunner<CR>

  " If text is selected, save it in the v buffer and send that buffer it to tmux
  vnoremap <Leader>vs "vy:<C-u>call VimuxSlime()<CR>
  " Select current paragraph and send it to tmux
  nmap <Leader>vs vip<Leader>vs<CR>
endif

" Options (many more set in vim-sensible) -------------------------------- {{{1
"
set completeopt=menu,longest           " Popup a menu for completion
set expandtab                          " Uses spaces for indent
set fillchars=vert:\|,fold:\           " Visual fill characters
set foldmethod=syntax                  " Fold based on file's syntax
set foldnestmax=1                      " Use one level of folds
set nofoldenable                       " But folds are mostly annoying
set hidden                             " Allow hidden buffers
set hlsearch                           " Highlight search hits
set number                             " Always display line numbers
set relativenumber                     " Relative line numbering
set shiftwidth=2                       " Number of spaces for autoindent
set showcmd                            " Show partial commands, areas
set showmatch                          " Highlight matching (){}[]
set noshowmode                         " Hide -- INSERT --
set updatetime=250                     " Make gitgutter update faster
set wildmode=longest,list,full         " Command line completion options

if exists('+colorcolumn')
  set colorcolumn=+1
endif

" netrw should never be my alternate file
let g:netrw_altfile=1

" vim-sensible calls this, but it doesn't seem to work for 7.2
syntax enable

" Colors & Fonts --------------------------------------------------------- {{{1
"
if has("gui_running")
  set guioptions-=T " Remove toolbar

  if g:WINDOWS
    set guifont=Consolas:h11
    set guioptions-=L " Prevent window resizing
  elseif has("gui_gtk2") || has("gui_gtk3")
    set guifont=Inconsolata\ Medium\ 12
  elseif g:OSX
    set guifont=Monaco:h13
  endif
else
  " Running in terminal
  set t_Co=256
endif

" Solarize colors if available
if !empty(globpath(&runtimepath, 'colors/apprentice.vim'))
  colorscheme apprentice
else
  colorscheme evening
endif

" Normal Mode Mappings --------------------------------------------------- {{{1
"
let mapleader="\\"
let maplocalleader=","

" Format paragraph
nnoremap Q gqip
" Yank to end of line
nnoremap Y y$
" Left/right cursor keys navigate in/out of tags
nnoremap <Left> <C-T>
nnoremap <Right> <C-]>
" Up/down cursor keys navigate windows
nnoremap <Up> <C-W>k
nnoremap <Down> <C-W>j
" Toggle folds with spacebar
nnoremap <Space> za
" Place cursor at start of . command
nnoremap . .`[

" Command mappings
nnoremap <silent> <Leader>ev :<C-u>edit $MYVIMRC<CR>:set fdm=marker<CR>
nnoremap <silent> <Leader>sl :<C-u>set list!<CR>
nnoremap <silent> <Leader>sn :<C-u>call ToggleNumber()<CR>
nnoremap <silent> <Leader>sp :<C-u>set paste!<CR>
nnoremap <silent> <Leader>sr :<C-u>set relativenumber!<CR>
nnoremap <silent> <Leader>ss :<C-u>set spell!<CR>
nnoremap <silent> <Leader>q :<C-u>call ToggleQFix()<CR>
nnoremap <silent> + :<C-u>resize +2<CR>
nnoremap <silent> _ :<C-u>resize -2<CR>

" Insert Mode Mappings --------------------------------------------------- {{{1
"
inoremap `jh James Hillyerd
inoremap `em james@hillyerd.com
inoremap jk <ESC>

" Auto Commands ---------------------------------------------------------- {{{1
"
if has("autocmd")
  augroup VIMRC
    autocmd!
    " Quickfix window
    autocmd QuickFixCmdPre * :update
    autocmd QuickFixCmdPost * :cwindow
    " Recognize .md as markdown, not modula2
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    " Run vimscript
    autocmd FileType vim nnoremap <buffer> <LocalLeader>r :<C-u>source %<CR>
  augroup END
endif

" Functions -------------------------------------------------------------- {{{1
"
" Toggle the quickfix window
function! ToggleQFix()
  for i in range(1, winnr('$'))
    if getbufvar(winbufnr(i), '&buftype') == 'quickfix'
      cclose
      return
    endif
  endfor
  copen
endfunction

" Toggle number+relativenumber and disable mouse for copying from terminal
function! ToggleNumber()
  if &number
    let s:rnum_state = &relativenumber
    set nonumber
    set norelativenumber
    if !has("gui_running")
      let s:mouse_opts=&mouse
      set mouse=
    endif
  else
    set number
    if exists("s:rnum_state")
      let &relativenumber = s:rnum_state
    endif
    if exists("s:mouse_opts") && !has("gui_running")
      execute "set mouse=" . s:mouse_opts
    endif
  endif
endfunction

" Better looking folds
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

" Language: Go ----------------------------------------------------------- {{{1
"
if has("autocmd")
  function! s:golang_settings()
    " Reformat comments using vim-commentary text object
    nmap <buffer> Q gqgc
    " Golang vimux mappings
    nnoremap <buffer> <LocalLeader>ra :<C-u>GolangTestCurrentPackage<CR>
    nnoremap <buffer> <LocalLeader>rf :<C-u>GolangTestFocused<CR>
    " vim-go mappings that perform an action
    " go-def is not reliable right now
    " nmap <buffer> <Right> <Plug>(go-def)
    " nmap <buffer> <Left> <Plug>(go-def-pop)
    nmap <buffer> <LocalLeader>a <Plug>(go-alternate-edit)
    nmap <buffer> <LocalLeader>b <Plug>(go-build)
    nmap <buffer> <LocalLeader>c <Plug>(go-coverage-toggle)
    nmap <buffer> <LocalLeader>e <Plug>(go-rename)
    nmap <buffer> <LocalLeader>i <Plug>(go-import)
    nmap <buffer> <LocalLeader>I <Plug>(go-imports)
    nmap <buffer> <LocalLeader>l <Plug>(go-metalinter)
    nmap <buffer> <LocalLeader>r <Plug>(go-run)
    nmap <buffer> <LocalLeader>t <Plug>(go-test)
    nmap <buffer> <LocalLeader>tt <Plug>(go-test-func)
    nmap <buffer> <LocalLeader>* <Plug>(go-sameids)
    " vim-go mappings that look up (show) something under the cursor
    nmap <buffer> <LocalLeader>sd <Plug>(go-describe)
    nmap <buffer> <LocalLeader>si <Plug>(go-implements)
    nmap <buffer> <LocalLeader>sr <Plug>(go-referrers)
    nmap <buffer> <LocalLeader>su <Plug>(go-info)
  endfunction
  augroup GOLANG
    autocmd!
    autocmd FileType go call s:golang_settings()
  augroup END
endif

" Language: JavaScript --------------------------------------------------- {{{1
"
if has("autocmd")
  augroup JAVASCRIPT
    autocmd!
    autocmd FileType javascript nmap <LocalLeader>l :<C-u>SyntasticCheck<CR>
  augroup END
endif

" Prose Mode ------------------------------------------------------------- {{{1
" From http://alols.github.io/2012/11/07/writing-prose-with-vim/
function! SetProse()
  " Break undo sequence at the end of sentences
  inoremap <buffer> . .<C-G>u
  inoremap <buffer> ! !<C-G>u
  inoremap <buffer> ? ?<C-G>u
  setlocal spell spelllang=en nolist nowrap textwidth=74 formatoptions=t1
  " Only auto-format during insert mode
  augroup PROSE
    autocmd!
    autocmd InsertEnter <buffer> set formatoptions+=a
    autocmd InsertLeave <buffer> set formatoptions-=a
  augroup END
  " Fix previous typo, return to cursor
  nnoremap <silent> <buffer> <LocalLeader>f :<C-u>normal! mm[s1z=`m<CR>
endfunction
command! Prose call SetProse()

" Reformat document: soft wrap paragraphs
" - Add a blank line to end of document
" - Join all non-blank lines
" - Remove trailing whitespace
" - Double-space
command! -range=% SoftWrap
      \ <line2>put _ |
      \ silent <line1>,<line2>g/\S/,/^\s*$/join | silent s/\s\+$// | put _
