local group = vim.api.nvim_create_augroup("mylsp", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = group,

  callback = function(ev)
    local map_opts = { noremap = true, silent = true, buffer = ev.buf }

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", map_opts)
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", map_opts)
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", map_opts)
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", map_opts)
    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", map_opts)
    vim.keymap.set("n", "<localleader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", map_opts)
    vim.keymap.set("n", "<localleader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", map_opts)
    vim.keymap.set("n", "<localleader>e", "<cmd>lua vim.lsp.buf.rename()<CR>", map_opts)
    vim.keymap.set("n", "<localleader>q", "<cmd>lua vim.lsp.buf.format{async = true}<CR>", map_opts)
    vim.keymap.set("n", "<localleader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
      map_opts)
    vim.keymap.set("n", "<localleader>wr",
      "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", map_opts)
    vim.keymap.set("n", "<localleader>wl",
      "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", map_opts)
  end
})

-- Local LSP config overrides when present.
local ok, myconfig = pcall(require, "local/lsp")
if not ok then
  myconfig = {
    servers = {
      -- rust handled by rust-tools.nvim.
      elmls = {},
      gleam = {},
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

      nixd = {},
      tsserver = {},
      yamlls = {},
    },
  }
end

return {
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",

      {
        "j-hui/fidget.nvim",
        version = "^1.3.0",
        opts = {},
      },
    },

    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Use a loop to conveniently call 'setup' on multiple servers and
      -- map buffer local keybindings when the language server attaches
      for name, config in pairs(myconfig.servers) do
        config.capabilities = capabilities
        lspconfig[name].setup(config)
      end
    end,
  },
}
