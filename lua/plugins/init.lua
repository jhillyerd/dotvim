local map_opts = { noremap = true, silent = true }

return {
  "dag/vim-fish",
  "airblade/vim-gitgutter",
  "jvirtanen/vim-hcl",
  "LnL7/vim-nix",
  "neoclide/jsonc.vim",
  "posva/vim-vue",
  "tpope/vim-commentary",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  "wincent/terminus",

  {
    "miyakogi/conoline.vim",
    init = function()
      vim.g.conoline_use_colorscheme_default_normal = 1
    end,
  },

  {
    "github/copilot.vim",
    init = function()
      vim.keymap.set("n", "<Leader>cn", "<Cmd>Copilot panel<Cr>", map_opts)
      vim.keymap.set("i", "<Right>", "copilot#Accept('<Right>')", {
        expr = true,
        replace_keycodes = false,
      })
      vim.keymap.set("i", "<C-Right>", "<Plug>(copilot-accept-word)", map_opts)

      vim.g.copilot_no_tab_map = true

      -- Allow copilot in devel subdirectories.
      local cwd = vim.fn.getcwd()
      if cwd:find(vim.env.HOME .. "/devel", 1, true) then
        vim.g.copilot_workspace_folders = { cwd }
      end
    end
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
    "rafcamlet/nvim-luapad",
    init = function()
      vim.keymap.set("n", "<Leader>lp", function ()
        require("luapad").toggle()
      end, map_opts)
    end,
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
