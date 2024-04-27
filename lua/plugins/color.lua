return {
  {
    "tjdevries/colorbuddy.nvim",

    config = function()
      local colorbuddy = require("colorbuddy")
      local colors = colorbuddy.colors
      local Group = colorbuddy.Group

      vim.cmd.colorscheme("gruvbuddy")
      Group.new("ColorColumn", colors.foreground, colors.background:light())
    end,
  },
}
