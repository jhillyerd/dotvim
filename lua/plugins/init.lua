local map_opts = { noremap = true, silent = true }

return {
  "dag/vim-fish",
  "airblade/vim-gitgutter",
  "jvirtanen/vim-hcl",
  "LnL7/vim-nix",
  "miyakogi/conoline.vim",
  "neoclide/jsonc.vim",
  "posva/vim-vue",
  "tpope/vim-commentary",
  "tpope/vim-repeat",
  "tpope/vim-sensible",
  "tpope/vim-surround",
  "tpope/vim-vinegar",
  "vim-airline/vim-airline",
  "wincent/terminus",

  {
    "folke/lazy.nvim",
    branch = "stable",
  },

  {
    "folke/neodev.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
  },

  {
    -- Function signature help.
    "ray-x/lsp_signature.nvim",
    opts = {
      doc_lines = 2,
      hint_enable = false,
    }
  },

  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<Leader>ga", "<Cmd>Gwrite<cr>", map_opts)
      vim.keymap.set("n", "<Leader>gb", "<Cmd>Git blame<cr>", map_opts)
      vim.keymap.set("n", "<Leader>gd", "<Cmd>Gdiffsplit<cr>", map_opts)
      vim.keymap.set("n", "<Leader>gs", "<Cmd>Git<cr>", map_opts)
    end
  },
}
