-- local map_opts = { noremap = true, silent = true }

return {
  "Exafunction/windsurf.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    print("in windsurf init")
    require("codeium").setup({
      -- virtual_text = {
      --   enabled = true,
      --   key_bindings = {
      --     -- accept = "<C-Right>",
      --     accept_word = "<C-Right>",
      --     -- accept_line = "<C-Up>",
      --     -- next = "<C-Down>",
      --     -- prev = "<C-Shift-Down>",
      --   },
      -- },
      wrapper = "/run/current-system/sw/bin/steam-run",
    })
  end,
}
