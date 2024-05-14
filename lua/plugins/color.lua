return {
  {
    "EdenEast/nightfox.nvim",

    lazy = false,

    config = function()
      local palettes = {
        nightfox = {
          bg0 = "#080808",
          bg1 = "#1c1c1c",
        },
      }

      require("nightfox").setup({ palettes = palettes })

      vim.cmd.colorscheme("nightfox")
    end,
  },
}
