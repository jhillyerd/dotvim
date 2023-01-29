local map_opts = { buffer=0, noremap=true, silent=false }

local group = vim.api.nvim_create_augroup("mylua", {})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  group = group,
  callback = function()
    -- Saves and runs this lua file within neovim.
    vim.keymap.set("n", "<LocalLeader>r", "<Cmd>write | messages clear | luafile %<cr>", map_opts)
  end,
})
