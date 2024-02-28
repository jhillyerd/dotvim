local map_opts = { buffer = 0, noremap = true, silent = false }

vim.keymap.set("n", "<LocalLeader>r", "<Cmd>TermExec cmd='gleam run'<cr>", map_opts)
vim.keymap.set("n", "<LocalLeader>t", "<Cmd>TermExec cmd='gleam test'<cr>", map_opts)
