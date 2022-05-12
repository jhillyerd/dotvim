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

" Leader Keys
let mapleader = "\\"
let maplocalleader = ","

" Google Init ------------------------------------------------------------ {{{1
if g:GOOGLE
  let s:googlevim = stdpath('config') . "/google.vim"
  if filereadable(s:googlevim)
    execute "source " . s:googlevim
  end
end

" Plug List -------------------------------------------------------------- {{{1
"
" Detect Plug
if !empty(globpath(&runtimepath, 'autoload/plug.vim'))
  call plug#begin(stdpath('data') . '/plugged')

  " github plugins, windows friendly
  Plug 'andys8/vim-elm-syntax', { 'for': 'elm' }
  Plug 'fatih/vim-go', { 'for': 'go', 'tag': 'v*' }
  Plug 'jlanzarotta/bufexplorer'
  Plug 'LnL7/vim-nix'
  Plug 'miyakogi/conoline.vim'
  Plug 'neoclide/jsonc.vim'
  Plug 'posva/vim-vue', { 'for': 'vue' }
  Plug 'romainl/Apprentice'
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-vinegar'
  Plug 'vim-airline/vim-airline'

  " github plugs, unix preferred
  if !g:WINDOWS
    Plug 'airblade/vim-gitgutter'
    Plug 'benmills/vimux'
    Plug 'benmills/vimux-golang'
    Plug 'dag/vim-fish', { 'for': 'fish' }
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'kassio/neoterm'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'wincent/terminus'
    Plug 'xolox/vim-misc'
    if !g:GOOGLE
      Plug 'dense-analysis/ale'
    end
  endif

  " All of your Plugins must be added before the following line (required)
  call plug#end()
endif

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

" CoC Configuration
if !empty(globpath(&runtimepath, 'autoload/coc.vim'))
  execute 'source ' . stdpath('config') . '/coc.vim'
endif

" Conoline Configuration
let g:conoline_use_colorscheme_default_normal=1

" Fugitive Configuration
nnoremap <Leader>ga :<C-u>Gwrite<CR>
nnoremap <Leader>gb :<C-u>Git blame<CR>
nnoremap <Leader>gd :<C-u>Gdiffsplit<CR>
nnoremap <Leader>gs :<C-u>Git<CR>

" FZF Configuration
if !empty(globpath(&runtimepath, 'autoload/fzf/vim.vim'))
  let g:fzf_layout = { 'up': '~30%' }
  nnoremap <C-p> :<C-u>FZF --reverse<CR>
  nnoremap <silent> <Leader>l :<C-u>BLines<CR>
endif

" Neoterm Configuration
let g:neoterm_auto_repl_cmd = 0
let g:neoterm_default_mod = "belowright split"
let g:neoterm_shell = "fish"
nmap <LocalLeader>gt <Plug>(neoterm-repl-send)
nmap <LocalLeader>gtl <Plug>(neoterm-repl-send-line)
xmap <LocalLeader>gt <Plug>(neoterm-repl-send)

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

" Wiki Configuration
let g:wiki_home = '~/wiki'

" YouCompleteMe Configuration
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" Options (many more set in vim-sensible) -------------------------------- {{{1
"
set nobackup
set nowritebackup
set cmdheight=2
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
set shortmess+=c                       " Don't pass to ins-completion-menu
set showcmd                            " Show partial commands, areas
set showmatch                          " Highlight matching (){}[]
set signcolumn=yes
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

set background=dark
if !empty(globpath(&runtimepath, 'colors/apprentice.vim'))
  colorscheme apprentice
endif

" Normal Mode Mappings --------------------------------------------------- {{{1
"
" Copy entire buffer into * register
nnoremap <silent> <Leader>* mxgg"*yG`x
" Transpose current word to the right
nnoremap gl "xdiwdwep"xp
" Format paragraph
nnoremap Q gqip
" Yank to end of line
nnoremap Y y$
" Left/right cursor keys navigate in/out of tags
nnoremap <Left> <C-T>
nnoremap <Right> <C-]>
" Open vertical split, move right
nnoremap <silent> <Leader>v <C-W>v<C-W>l
" Toggle folds with spacebar
nnoremap <Space> za
" Place cursor at start of . command
nnoremap . .`[
" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <silent> <Leader><Leader> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Command mappings
nnoremap <silent> <Leader>ev :<C-u>edit $MYVIMRC<CR>:set fdm=marker<CR>
nnoremap <silent> <Leader>sl :<C-u>set list!<CR>
nnoremap <silent> <Leader>sn :<C-u>call ToggleNumber()<CR>
nnoremap <silent> <Leader>sp :<C-u>set paste!<CR>
nnoremap <silent> <Leader>sr :<C-u>set relativenumber!<CR>
nnoremap <silent> <Leader>ss :<C-u>set spell!<CR>
nnoremap <silent> <Leader>q :<C-u>call ToggleQFix()<CR>
nnoremap <silent> <Leader>wj :<C-u>call wiki#journal()<CR>
nnoremap <silent> <Leader>x :<C-u>e ~/buffer.md<CR>
nnoremap <silent> + :<C-u>resize +2<CR>
nnoremap <silent> _ :<C-u>resize -2<CR>

" Insert Mode Mappings --------------------------------------------------- {{{1
"
inoremap jk <ESC>

" Terminal Mode Mappings ------------------------------------------------- {{{1
"
nnoremap <silent> <Leader>z :<C-u>belowright split \| startinsert \| terminal fish<CR>
tnoremap jk <C-\><C-N>
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
augroup VIMRCTERM
  autocmd TermOpen * setlocal nonumber
  autocmd TermOpen * setlocal norelativenumber
  autocmd TermClose term://*fish | :close
  autocmd BufEnter term://*fish | :startinsert
augroup END

" Auto Commands ---------------------------------------------------------- {{{1
"
if has("autocmd")
  augroup VIMRC
    autocmd!
    " Quickfix window
    autocmd QuickFixCmdPre * :update
    " Recognize .md as markdown, not modula2
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    " Run vimscript
    autocmd FileType vim nnoremap <buffer> <LocalLeader>r :<C-u>source %<CR>
    " Delete hidden netrw buffers
    autocmd FileType netrw setlocal bufhidden=wipe
  augroup END
endif

" Commands --------------------------------------------------------------- {{{1
"
command! Here :cd %:p:h

" Functions -------------------------------------------------------------- {{{1
"
" diff mode settings
if has("autocmd")
  function! s:diff_settings()
    if &diff
      " Up/down cursor keys navigate diff hunks
      nmap <Up> [cz.
      nmap <Down> ]cz.
    else
      if !empty(globpath(&runtimepath, 'autoload/coc.vim'))
        nmap <silent> <Up> <Plug>(coc-diagnostic-prev)
        nmap <silent> <Down> <Plug>(coc-diagnostic-next)
      else
        " Up/down cursor keys navigate quickfix items
        nmap <silent> <Up> :<C-u>cprevious<CR>
        nmap <silent> <Down> :<C-u>cnext<CR>
      endif
    endif
  endfunction
  augroup DIFF
    autocmd!
    autocmd BufEnter * call s:diff_settings()
  augroup END
endif

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
    let g:go_fmt_experimental = 1
    let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck',
          \ 'megacheck']
    let g:go_list_type = "quickfix"
    let g:go_term_mode = "belowright split"
    " Reformat comments using vim-commentary text object
    nmap <buffer> Q gqgc
    " Golang vimux mappings
    nnoremap <buffer> <LocalLeader>ra :<C-u>GolangTestCurrentPackage<CR>
    nnoremap <buffer> <LocalLeader>rf :<C-u>GolangTestFocused<CR>
    " vim-go mappings that perform an action
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

" Language: Markdown ----------------------------------------------------- {{{1
"
if has("autocmd")
  augroup MARKDOWN
    autocmd!
    autocmd FileType markdown setlocal spell
    autocmd FileType markdown nnoremap <silent> <buffer> <LocalLeader>f :<C-u>normal! mm[s1z=`m<CR>
  augroup END
endif

" Language: Nix ----------------------------------------------------------
"
if has("autocmd")
  augroup NIX
    autocmd!
    autocmd FileType nix nnoremap <silent> <buffer> <LocalLeader>q :<C-u>%!nixfmt<CR>
  augroup END
endif

" Language: Rust---------------------------------------------------------- {{{1
"
if has("autocmd")
  function! s:rust_settings()
    let g:rustfmt_autosave = 1

    nmap <buffer> <LocalLeader>b :<C-u>Ccheck<CR>
    nmap <buffer> <LocalLeader>r :<C-u>Crun<CR>
    nmap <buffer> <LocalLeader>t :<C-u>RustTest!<CR>
    nmap <buffer> <LocalLeader>tt :<C-u>RustTest<CR>
  endfunction

  augroup RUST
    autocmd!
    autocmd FileType rust call s:rust_settings()
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
