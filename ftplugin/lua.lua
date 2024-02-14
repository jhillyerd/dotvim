local map_opts = { buffer = 0, noremap = true, silent = false }

-- Saves and runs this lua file within neovim.
vim.keymap.set("n", "<LocalLeader>r", "<Cmd>write | messages clear | luafile %<cr>", map_opts)
