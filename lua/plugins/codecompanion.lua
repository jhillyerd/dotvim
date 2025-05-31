local map_opts = { noremap = true, silent = true }

return {
  {
    "olimorris/codecompanion.nvim",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",

      {
        "echasnovski/mini.diff",
        config = function()
          local diff = require("mini.diff")
          diff.setup({
            -- Disabled by default
            source = diff.gen_source.none(),
          })
        end,
      },
    },

    opts = {},

    init = function()
      vim.keymap.set("n", "<Leader>ca", "<Cmd>CodeCompanionAction<Cr>", map_opts)
      vim.keymap.set("n", "<Leader>cc", "<Cmd>CodeCompanionChat<Cr>", map_opts)
      vim.keymap.set("n", "<Leader>cn", "<Cmd>Copilot panel<Cr>", map_opts)
      vim.keymap.set("i", "<Right>", "copilot#Accept('<Right>')", {
        expr = true,
        replace_keycodes = false,
      })
      vim.keymap.set("i", "<C-Right>", "<Plug>(copilot-accept-word)", map_opts)

      vim.g.copilot_no_tab_map = true
    end
  },
}
