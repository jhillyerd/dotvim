require("nvim-treesitter.configs").setup {
  ensure_installed = { "go", "http", "json", "lua", "nix", "rust" },

  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Jump forward like %
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
      -- Prevent nvim-treesitter/ts_utils.lua:285: Column value outside range
      -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/377
      include_surrounding_whitespace = false,
    },
  },
}
