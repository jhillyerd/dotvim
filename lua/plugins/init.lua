local map_opts = { noremap = true, silent = true }

return {
  "dag/vim-fish",
  "airblade/vim-gitgutter",
  "gleam-lang/gleam.vim",
  "jvirtanen/vim-hcl",
  "LnL7/vim-nix",
  "neoclide/jsonc.vim",
  "posva/vim-vue",
  "tpope/vim-commentary",
  "tpope/vim-repeat",
  "tpope/vim-sensible",
  "tpope/vim-surround",
  "wincent/terminus",

  {
    "augmentcode/augment.vim",
    init = function()
      vim.g.augment_workspace_folders = { "." }
      vim.g.augment_disable_tab_mapping = true
      vim.keymap.set("n", "<Leader>cc", ":Augment chat<cr>", map_opts)
      vim.keymap.set("n", "<Leader>ct", ":Augment chat-toggle<cr>", map_opts)
      vim.keymap.set("i", "<Right>", '<Cmd>call augment#Accept("\\<Right>")<cr>', map_opts)
    end,
  },

  {
    "miyakogi/conoline.vim",
    init = function()
      vim.g.conoline_use_colorscheme_default_normal = 1
    end,
  },

  {
    "folke/lazy.nvim",
    tag = "stable",
  },

  {
    "stevearc/oil.nvim",
    opts = {},
    init = function()
      vim.keymap.set("n", "-", "<Cmd>Oil<cr>", map_opts)
    end,
  },

  {
    "folke/neodev.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = false,
      },
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1,
          },
        },
      },
    },
    dependencies = {
      "EdenEast/nightfox.nvim",
      "nvim-tree/nvim-web-devicons",
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
    init = function()
      vim.keymap.set("n", "<Leader>ga", "<Cmd>Gwrite<cr>", map_opts)
      vim.keymap.set("n", "<Leader>gb", "<Cmd>Git blame<cr>", map_opts)
      vim.keymap.set("n", "<Leader>gd", "<Cmd>Gdiffsplit<cr>", map_opts)
      vim.keymap.set("n", "<Leader>gs", "<Cmd>Git<cr>", map_opts)
    end
  },
}
