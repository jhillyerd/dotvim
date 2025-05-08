return {
  "mrcjkb/rustaceanvim",
  version = '^5',
  lazy = false, -- This plugin is already lazy
  init = function()
    vim.g.rustaceanvim = {
      -- LSP configuration
      server = {
        default_settings = {
          -- rust-analyzer language server configuration.
          ['rust-analyzer'] = {
            check = {
              command = "check",
            },
            checkOnSave = false,
          },
        },
      },
    }
  end,
}
