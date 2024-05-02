return {
  {
    "EdenEast/nightfox.nvim",

    lazy = false,

    config = function()
      local palettes = {
        nightfox = {
          bg0 = "#101010",
          bg1 = "#202020",
        },
      }

      require("nightfox").setup({ palettes = palettes })

      vim.cmd.colorscheme("nightfox")
    end,
  },
}
