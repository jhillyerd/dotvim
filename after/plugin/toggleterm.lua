local map_opts = { noremap=true, silent=true }

local ok, toggleterm = pcall(require, 'toggleterm')
if ok then
  toggleterm.setup{
    open_mapping = [[<leader>t]],
    insert_mappings = false,
    terminal_mappings = false,

    -- auto_scroll = true,
    direction = 'vertical',
    size = 80,

    shell = "fish",
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
