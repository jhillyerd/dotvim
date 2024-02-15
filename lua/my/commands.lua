-- Lua port of http://alols.github.io/2012/11/07/writing-prose-with-vim/
local autocmd = vim.api.nvim_create_autocmd
local map_opts = { buffer = 0, noremap = true, silent = true }

vim.api.nvim_create_user_command("Here", ":cd %:p:h", {})

local enable_prose = function()
  -- Set buffer options.
  vim.opt_local.spell = true
  vim.opt_local.spelllang = "en"
  vim.opt_local.list = false
  vim.opt_local.wrap = false
  vim.opt_local.textwidth = 74
  vim.opt_local.formatoptions = { t = true, [1] = true }

  -- Break undo sequence at the end of sentences.
  vim.keymap.set("i", ".", ".<C-G>u", map_opts)
  vim.keymap.set("i", "!", "!<C-G>u", map_opts)
  vim.keymap.set("i", "?", "?<C-G>u", map_opts)

  -- Fix previous typo, return to cursor.
  vim.keymap.set("n", "<LocalLeader>f", ":<C-u>normal! mm[s1z=`m<CR>")

  -- Only auto-format during insert mode.
  local group = vim.api.nvim_create_augroup("prose", { clear = true })
  autocmd("InsertEnter", {
    pattern = "<buffer>",
    callback = function() vim.opt_local.formatoptions:append({ a = true }) end,
    group = group,
  })
  autocmd("InsertLeave", {
    pattern = "<buffer>",
    callback = function() vim.opt_local.formatoptions:append({ a = false }) end,
    group = group,
  })
end

vim.api.nvim_create_user_command("Prose", enable_prose, {})

-- Reformat document for pasting: soft wrap paragraphs
-- * Add a blank line to end of document
-- * Join all non-blank lines
-- * Remove trailing whitespace
-- * Double-space
vim.api.nvim_create_user_command("SoftWrap", [[
  <line2>put _ |
  silent <line1>,<line2>g/\S/,/^\s*$/join |
  silent s/\s\+$// |
  put _
]], { range = "%" })
