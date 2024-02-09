return {
  -- TODO: Deprecated, probably switch to:
  -- https://github.com/mrcjkb/rustaceanvim

  "simrat39/rust-tools.nvim",

  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "neovim/nvim-lspconfig",
  },

  config = function()
    local tools = require('rust-tools')
    tools.setup({
      server = {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          ["rust-analyzer"] = {
            procMacro = { enable = true },
          },
        },
      },
    })

    -- Very basic cargo run impl for embedded projects.
    local cargo_run_cmd = function()
      tools.config.options.tools.executor.execute_command('cargo', { 'run' }, '.')
    end

    local group = vim.api.nvim_create_augroup('rust-tools', {})
    vim.api.nvim_create_autocmd('FileType', {
      pattern = "rust",
      group = group,
      callback = function()
        vim.keymap.set('n', '<localleader>r', cargo_run_cmd, { buffer = 0 })
        vim.keymap.set('n', '<localleader>R', tools.runnables.runnables, { buffer = 0 })
      end,
    })
  end
}
