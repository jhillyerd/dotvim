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
let g:UNIX = has('unix') && !has('macunix') && !has('win32unix')
let g:WINDOWS = (has('win32') || has('win64'))

" Leader Keys
let mapleader = " "
let maplocalleader = ","

" Plug List -------------------------------------------------------------- {{{1
"
" Detect Plug
if !empty(globpath(&runtimepath, 'autoload/plug.vim'))
  call plug#begin(stdpath('data') . '/plugged')

  " dependencies
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'ray-x/guihua.lua'
  Plug 'tjdevries/colorbuddy.vim'

  " github plugins, windows friendly
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
    Plug 'akinsho/toggleterm.nvim', {'tag' : '2.3.*'}
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
" Conoline Configuration
let g:conoline_use_colorscheme_default_normal=1

" Options (many more set in vim-sensible) -------------------------------- {{{1
"
set cmdheight=2
set colorcolumn=+1
set expandtab                          " Uses spaces for indent
set foldmethod=syntax                  " Fold based on file's syntax
set foldnestmax=1                      " Use one level of folds
set formatoptions=cqlj                 " Control comment formatting
set nofoldenable                       " But folds are mostly annoying
set nohlsearch
set number                             " Always display line numbers
set relativenumber                     " Relative line numbering
set shiftwidth=2                       " Number of spaces for autoindent
set showmatch                          " Highlight matching (){}[]
set signcolumn=yes
set noshowmode                         " Hide -- INSERT --
set updatetime=500                     " Make gitgutter update faster
set virtualedit=block
set wildmode=longest,list,full         " Command line completion options

" netrw should never be my alternate file
let g:netrw_altfile=1

" Commands --------------------------------------------------------------- {{{1
"
command! Here :cd %:p:h

" Language: Markdown ----------------------------------------------------- {{{1
"
if has("autocmd")
  let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'sh']
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
