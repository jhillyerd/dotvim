return {
  "mrcjkb/rustaceanvim",
  version = '^7',
  lazy = false, -- This plugin is already lazy

  init = function()
    vim.g.rustaceanvim = {
      tools = { test_executor = 'background' },

      -- LSP configuration
      server = {
        cmd = function()
          -- Use a project-local wrapper when present (e.g. for ESP/xtensa
          -- projects where the custom toolchain lacks rust-analyzer).
          local buf_path = vim.api.nvim_buf_get_name(0)
          local root = vim.fs.root(buf_path, { 'Cargo.toml' })
          if root then
            local wrapper = root .. '/rust-analyzer-esp'
            if vim.uv.fs_stat(wrapper) then
              return { wrapper }
            end
          end
          return { 'rust-analyzer' }
        end,
        default_settings = {
          -- rust-analyzer language server configuration.
          ['rust-analyzer'] = {
            check = { command = "check" },
            checkOnSave = false,
          },
        },
      },
    }
  end,
}
