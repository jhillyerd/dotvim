local map_opts = { buffer=0, noremap=true, silent=false }

-- For :make to test syntax
vim.cmd.compiler("fish")

-- Wrap long lines inside comments.
vim.opt_local.textwidth = 79

-- Enable folding of block structures in fish.
vim.opt_local.foldmethod = "expr"

-- Saves and runs this fish script in a terminal.
vim.keymap.set("n", "<LocalLeader>r",
  "<Cmd>write | TermExec cmd='fish %'<cr>", map_opts)
