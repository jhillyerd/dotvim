local map_opts = { noremap = true, silent = true }

local group = vim.api.nvim_create_augroup("mylsp", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = group,

  callback = function(ev)
    -- TODO: update for vim.bo and vim.keymap.set
    local bufnr = ev.buf

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>e', '<cmd>lua vim.lsp.buf.rename()<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>q', '<cmd>lua vim.lsp.buf.format{async = true}<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
      map_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>wr',
      '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', map_opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>wl',
      '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', map_opts)
  end
})

-- Local LSP config overrides when present.
local ok, myconfig = pcall(require, 'local/lsp')
if not ok then
  myconfig = {
    servers = {
      -- rust handled by rust-tools.nvim.
      elmls = {},
      gopls = {},

      lua_ls = {
        settings = {
          Lua = {
            workspace = {
              -- Prevents `Do you need to configure your work environment as luv` popup.
              checkThirdParty = false, -- Soon: "Disable",
            },
          },
        },
      },

      rnix = {},
      tsserver = {},
      yamlls = {},
    },
  }
end

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      -- TODO extract
      local def_cap = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- Use a loop to conveniently call 'setup' on multiple servers and
      -- map buffer local keybindings when the language server attaches
      for name, config in pairs(myconfig.servers) do
        config.capabilities = def_cap
        lspconfig[name].setup(config)
      end
    end,
  },
}
