require "my.augroups"
require "my.commands"
require "my.keymaps"

-- Useful definitions
local map_opts         = { noremap = true, silent = true }

-- Options (many more set in vim-sensible)
vim.opt.cmdheight      = 2
vim.opt.colorcolumn    = "+1"
vim.opt.expandtab      = true     -- Uses spaces for indent
vim.opt.foldmethod     = "syntax" -- Fold based on file's syntax
vim.opt.foldnestmax    = 1        -- Use one level of folds
vim.opt.foldenable     = false    -- But folds are mostly annoying
vim.opt.hlsearch       = false
vim.opt.number         = true     -- Always display line numbers
vim.opt.relativenumber = true     -- Relative line numbering
vim.opt.shiftwidth     = 2        -- Number of spaces for autoindent
vim.opt.showmatch      = true     -- Highlight matching (){}[]
vim.opt.signcolumn     = "yes"
vim.opt.showmode       = false    -- Hide `-- INSERT --`
vim.opt.updatetime     = 500      -- Make gitgutter update faster
vim.opt.virtualedit    = "block"

-- Control comment formatting
vim.opt.formatoptions  = { c = true, q = true, l = true, j = true }
-- Command line completion options
vim.opt.wildmode       = { longest = true, list = true, full = true }

-- Colors
do
  local Color, colors, Group, groups, styles = require('colorbuddy').setup()
  require('colorbuddy').colorscheme('gruvbuddy')
  Group.new('ColorColumn', colors.foreground, colors.background:light())
end

-- LSP setup
--
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', map_opts)
vim.api.nvim_set_keymap('n', '<up>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', map_opts)
vim.api.nvim_set_keymap('n', '<down>', '<cmd>lua vim.diagnostic.goto_next()<CR>', map_opts)
-- vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', map_opts)

-- Use an on_attach function to only map the following keys after the language
-- server attaches to the current buffer.
LSP_ON_ATTACH = function(_, bufnr)
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
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', map_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>wr',
    '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', map_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>wl',
    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', map_opts)
end

-- Neovim/Lua plugin dev tools.
require("neodev").setup()

-- LSP configuration via lspconfig plugin.
do
  -- Local LSP config overrides when present.
  local ok, myconfig = pcall(require, 'local/lsp')
  if not ok then
    myconfig = {
      servers = {
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

  local lspconfig = require("lspconfig")
  local def_cap = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  for name, config in pairs(myconfig.servers) do
    config.capabilities = def_cap
    config.on_attach = LSP_ON_ATTACH

    lspconfig[name].setup(config)
  end
end

-- Add function signature help.
require("lsp_signature").setup({
  doc_lines = 2,
  hint_enable = false,
})

-- Language: Rust
do
  require("rust-tools").setup({
    server = {
      capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
      on_attach = LSP_ON_ATTACH,
      settings = {
        ["rust-analyzer"] = {
          procMacro = { enable = true },
        },
      },
    },
  })

  -- Very basic cargo run impl for embedded projects.
  local tools = require('rust-tools')
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
