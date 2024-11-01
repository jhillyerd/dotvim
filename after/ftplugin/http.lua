local map_opts = { noremap = true, silent = false }

vim.keymap.set("n", "<LocalLeader>r", ":Rest run<Cr>", map_opts)
