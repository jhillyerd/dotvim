return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",

  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },

  config = function()
    local ensure_installed = {}

    if vim.fn.has('unix') then
      ensure_installed = {
        "go", "http", "json", "lua", "nix", "rust", "terraform", "vim", "vimdoc"
      }
    end

    require("nvim-treesitter").setup {
      ensure_installed = ensure_installed,
    }

    require("nvim-treesitter-textobjects").setup {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
        },
        include_surrounding_whitespace = true,
      },
    }

    require("treesitter-context").setup({
      max_lines = 1,
    })

    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
  end,
}
