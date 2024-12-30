local map_opts = { buffer = 0, noremap = true, silent = true }

-- Kills terminal session, closes window.
vim.keymap.set("n", "q", ":<C-u>q!<Cr>", map_opts)
