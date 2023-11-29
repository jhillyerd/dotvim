local map_opts = { buffer=0, noremap=true, silent=false }

local dap_ok, dapgo = pcall(require, "dap-go")
if dap_ok then
  dapgo.setup()
end

local group = vim.api.nvim_create_augroup('go-nvim', {})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = "*.go",
  group = group,
  callback = function()
    require('go.format').goimport()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = "go",
  group = group,
  callback = function()
    require('go').setup({
      gofmt = 'gopls',
      luasnip = 'true',
    })
    vim.keymap.set("n", "<LocalLeader>a", "<Cmd>GoAlt<cr>", map_opts)
    vim.keymap.set("n", "<LocalLeader>I", "<Cmd>GoImport<cr>", map_opts)
    vim.keymap.set(
      "n", "<LocalLeader>r", "<Cmd>TermExec cmd='go run %'<cr>", map_opts)
    vim.keymap.set("n", "<LocalLeader>t", "<Cmd>GoTestFile<cr>", map_opts)
    vim.keymap.set("n", "<LocalLeader>tt", "<Cmd>GoTestFunc<cr>", map_opts)

    if dap_ok then
      vim.keymap.set("n", "<LocalLeader>dt", dapgo.debug_test, map_opts)
    end
  end,
})
