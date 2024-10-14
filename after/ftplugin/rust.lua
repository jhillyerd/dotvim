local map_opts = { noremap = true, silent = true }

vim.keymap.set("n", "<LocalLeader>cc", ":RustLsp flyCheck<Cr>", map_opts)

vim.keymap.set("n", "<LocalLeader>t", function()
  vim.notify("Fetching testables...")
  vim.cmd.RustLsp({ "testables", bang = true })
end, map_opts)

vim.keymap.set("n", "<LocalLeader>tt", function()
  vim.notify("Fetching testables...")
  vim.cmd.RustLsp({ "testables" })
end, map_opts)

vim.keymap.set("n", "<LocalLeader>sf", 'v2i"cString::from(<C-r>")<Esc>', map_opts)
