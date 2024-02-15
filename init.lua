-- Options (many more set in vim-sensible)
do
  vim.opt.cmdheight      = 2
  vim.opt.colorcolumn    = "+1"
  vim.opt.expandtab      = true            -- Uses spaces for indent
  vim.opt.foldmethod     = "syntax"        -- Fold based on file's syntax
  vim.opt.foldnestmax    = 1               -- Use one level of folds
  vim.opt.foldenable     = false           -- But folds are mostly annoying
  vim.opt.hlsearch       = false
  vim.opt.number         = true            -- Always display line numbers
  vim.opt.relativenumber = true            -- Relative line numbering
  vim.opt.shiftwidth     = 2               -- Number of spaces for autoindent
  vim.opt.showmatch      = true            -- Highlight matching (){}[]
  vim.opt.signcolumn     = "yes"
  vim.opt.showmode       = false           -- Hide `-- INSERT --`
  vim.opt.updatetime     = 500             -- Make gitgutter update faster
  vim.opt.virtualedit    = "block"

  -- Control comment formatting
  vim.opt.formatoptions  = { c = true, q = true, l = true, j = true }

  -- Command line completion options
  vim.opt.wildmode       = { "longest", "list", "full" }
end

-- Vim global variables
do
  vim.g.mapleader                 = " "
  vim.g.maplocalleader            = ","

  -- netrw should never be my alternate file
  vim.g.netrw_altfile             = 1

  vim.g.markdown_fenced_languages = { 'html', 'python', 'bash=sh', 'sh' }
end

-- Init lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
  change_detection = { enabled = false },
})

require "my.augroups"
require "my.commands"
require "my.filetypes"
require "my.keymaps"
