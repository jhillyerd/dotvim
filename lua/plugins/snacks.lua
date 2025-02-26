return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  opts = {
    lazygit = {
      configure = true,
    },
  },

  keys = {
    { "<Leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
  },
}
