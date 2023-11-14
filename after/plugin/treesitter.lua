local ensure_installed = {}

if vim.g.UNIX == 1 then
  ensure_installed = {
    "go", "http", "json", "lua", "nix", "rust", "terraform"
  }
end

require("nvim-treesitter.configs").setup {
  ensure_installed = ensure_installed,

  highlight = {
    enable = true,
  },

  indent = {
    enable = true,
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Jump forward like %
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
      include_surrounding_whitespace = true,
    },
  },
}
