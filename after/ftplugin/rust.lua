local map_opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Leader>ca", function()
  vim.cmd.RustLsp("codeAction")
end, map_opts)

vim.keymap.set("n", "K", function()
  vim.cmd.RustLsp({ "hover", "actions" })
end, map_opts)

vim.keymap.set("n", "<LocalLeader>cc", ":RustLsp flyCheck<Cr>", map_opts)

vim.keymap.set("n", "<LocalLeader>t", function()
  vim.notify("Fetching testables...")
  vim.cmd.RustLsp({ "testables" })
end, map_opts)

vim.keymap.set("n", "<LocalLeader>tt", function()
  vim.notify("Running last testable...")
  vim.cmd.RustLsp({ "testables", bang = true })
end, map_opts)

vim.keymap.set("n", "<LocalLeader>sf", 'v2i"cString::from(<C-r>")<Esc>', map_opts)
