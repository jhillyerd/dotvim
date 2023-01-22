local map_opts = { noremap=true, silent=true }

vim.keymap.set("n", "<Leader>ga", "<Cmd>Gwrite<cr>", map_opts)
vim.keymap.set("n", "<Leader>gb", "<Cmd>Git blame<cr>", map_opts)
vim.keymap.set("n", "<Leader>gd", "<Cmd>Gdiffsplit<cr>", map_opts)
vim.keymap.set("n", "<Leader>gs", "<Cmd>Git<cr>", map_opts)
