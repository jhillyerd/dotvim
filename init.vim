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
let mapleader = " "
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

  " dependencies
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'tjdevries/colorbuddy.vim'

  " github plugins, windows friendly
  Plug 'jlanzarotta/bufexplorer'
  Plug 'lervag/wiki.vim'
  Plug 'LnL7/vim-nix'
  Plug 'miyakogi/conoline.vim'
  Plug 'neoclide/jsonc.vim'
  Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
  Plug 'posva/vim-vue', { 'for': 'vue' }
  Plug 'ray-x/go.nvim'
  Plug 'ray-x/lsp_signature.nvim'
  Plug 'simrat39/rust-tools.nvim'
  Plug 'ThePrimeagen/harpoon'
  Plug 'tjdevries/gruvbuddy.nvim'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-vinegar'
  Plug 'vim-airline/vim-airline'

  " completion setup
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'

  " github plugs, unix preferred
  if !g:WINDOWS
    Plug 'airblade/vim-gitgutter'
    Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
    Plug 'dag/vim-fish', { 'for': 'fish' }
    Plug 'unisonweb/unison', { 'branch': 'trunk', 'rtp': 'editor-support/vim' }
    Plug 'wincent/terminus'
    Plug 'xolox/vim-misc'
  endif

  " All of your Plugins must be added before the following line (required)
  call plug#end()
endif

lua require('config')

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

" Conoline Configuration
let g:conoline_use_colorscheme_default_normal=1

" Fugitive Configuration
nnoremap <Leader>ga :<C-u>Gwrite<CR>
nnoremap <Leader>gb :<C-u>Git blame<CR>
nnoremap <Leader>gd :<C-u>Gdiffsplit<CR>
nnoremap <Leader>gs :<C-u>Git<CR>

" Wiki Configuration
if !empty(globpath(&runtimepath, 'autoload/wiki.vim'))
  let g:wiki_root = '~/wiki'
  let g:wiki_filetypes = ['md']
  let g:wiki_link_extension = '.md'

  let g:wiki_mappings_local_journal = {
        \ '<plug>(wiki-journal-prev)' : '<A-Left>',
        \ '<plug>(wiki-journal-next)' : '<A-Right>',
        \}
endif

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
set formatoptions=cqlj                 " Control comment formatting
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
set virtualedit=block
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
" Place cursor at start of . command
nnoremap . .`[
" Window navigation
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
nnoremap <silent> <C-l> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-l>

" Command mappings
nnoremap <silent> <Leader>ev :<C-u>edit $MYVIMRC<CR>:set fdm=marker<CR>
nnoremap <silent> <Leader>sl :<C-u>set list!<CR>
nnoremap <silent> <Leader>sn :<C-u>call ToggleNumber()<CR>
nnoremap <silent> <Leader>sp :<C-u>set paste!<CR>
nnoremap <silent> <Leader>sr :<C-u>set relativenumber!<CR>
nnoremap <silent> <Leader>ss :<C-u>set spell!<CR>
nnoremap <silent> <Leader>q :<C-u>call ToggleQFix()<CR>
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
tnoremap <M-h> <C-\><C-N><C-w>h
tnoremap <M-j> <C-\><C-N><C-w>j
tnoremap <M-k> <C-\><C-N><C-w>k
tnoremap <M-l> <C-\><C-N><C-w>l
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
  let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'sh']
  augroup MARKDOWN
    autocmd!
    autocmd FileType markdown nnoremap <silent> <buffer> <LocalLeader>f :<C-u>normal! mm[s1z=`m<CR>
  augroup END
endif

" Language: Prose -------------------------------------------------------- {{{1
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
