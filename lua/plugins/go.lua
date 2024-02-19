local map_opts = { buffer = 0, noremap = true, silent = false }

return {
  "ray-x/go.nvim",

  dependencies = {
    "ray-x/guihua.lua",
    "leoluz/nvim-dap-go",
  },

  config = function()
    require("go").setup({
      gofmt = "gopls",
      luasnip = "true",
    })

    local dap_go = require("dap-go")
    dap_go.setup()

    local group = vim.api.nvim_create_augroup("go-nvim", {})

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      group = group,
      callback = function()
        require("go.format").goimport()
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "go",
      group = group,
      callback = function()
        vim.keymap.set("n", "<LocalLeader>a", "<Cmd>GoAlt<cr>", map_opts)
        vim.keymap.set("n", "<LocalLeader>I", "<Cmd>GoImport<cr>", map_opts)
        vim.keymap.set(
          "n", "<LocalLeader>r", "<Cmd>TermExec cmd='go run %'<cr>", map_opts)
        vim.keymap.set("n", "<LocalLeader>t", "<Cmd>GoTestFile<cr>", map_opts)
        vim.keymap.set("n", "<LocalLeader>tt", "<Cmd>GoTestFunc<cr>", map_opts)

        vim.keymap.set("n", "<LocalLeader>dt", dap_go.debug_test, map_opts)

        vim.api.nvim_create_user_command("Lint", [[:cexpr system("golangci-lint run")]], {})
      end,
    })
  end
}
