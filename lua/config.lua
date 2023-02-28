require "my.keymaps"
require "my.augroups"

-- Useful definitions
--
local map_opts = { noremap=true, silent=true }

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
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', map_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', map_opts)
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
        lua_ls = {},
        rnix = {},
        tsserver = {},
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
require'lsp_signature'.setup({
  doc_lines = 2,
  hint_enable = false,
})

-- Plugin: Harpoon
do
  local mark = require('harpoon.mark')
  local ui = require('harpoon.ui')
  vim.keymap.set('n', '<leader><leader>', ui.toggle_quick_menu, {})
  vim.keymap.set('n', '<leader>a', mark.add_file, {})
  vim.keymap.set('n', '<leader>1', function() ui.nav_file(1) end, {})
  vim.keymap.set('n', '<leader>2', function() ui.nav_file(2) end, {})
  vim.keymap.set('n', '<leader>3', function() ui.nav_file(3) end, {})
  vim.keymap.set('n', '<leader>4', function() ui.nav_file(4) end, {})
  vim.keymap.set('n', '<leader>5', function() ui.nav_file(5) end, {})
  vim.keymap.set('n', '<leader>6', function() ui.nav_file(6) end, {})
  vim.keymap.set('n', '<leader>7', function() ui.nav_file(7) end, {})
  vim.keymap.set('n', '<leader>8', function() ui.nav_file(8) end, {})
  vim.keymap.set('n', '<leader>9', function() ui.nav_file(9) end, {})
end

-- Plugin: ToggleTerm
do
  require('toggleterm').setup{
    open_mapping = [[<leader>t]],
    insert_mappings = false,
    terminal_mappings = false,

    -- auto_scroll = true,
    direction = 'vertical',
    size = vim.o.columns * 0.4,
  }

  local Terminal = require("toggleterm.terminal").Terminal

  -- lazygit in a floating terminal.
  local lazygit = Terminal:new({
    cmd = "lazygit",
    direction = "float",
    hidden = true,
  })
  vim.keymap.set("n", "<leader>gg", function() lazygit:toggle() end, map_opts)
end

-- Language: Rust
do
  require('rust-tools').setup({
    server = {
      capabilities = require'cmp_nvim_lsp'.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
      on_attach = LSP_ON_ATTACH,
      settings = {
        ["rust-analyzer"] = {
          procMacro = { enable = true },
        },
      },
    },
  })

  -- Very basic cargo run impl for embedded projects.
  local cargo_run_cmd = function()
    local tools = require('rust-tools')
    tools.config.options.tools.executor.execute_command('cargo', { 'run' }, '.')
  end

  local group = vim.api.nvim_create_augroup('rust-tools', {})
  vim.api.nvim_create_autocmd('FileType', {
    pattern = "rust",
    group = group,
    callback = function()
      vim.keymap.set('n', '<localleader>r', cargo_run_cmd, { buffer = 0 })
    end,
  })
end

-- Language: Unison
do
  local group = vim.api.nvim_create_augroup('unison', {})
  vim.api.nvim_create_autocmd('FileType', {
    pattern = "unison",
    group = group,
    callback = function()
      vim.bo.commentstring = '-- %s'
      vim.keymap.set('n', '<localleader>r', '<cmd>botright vsplit term://ucm<cr>', { buffer = 0 })
    end,
  })
end
