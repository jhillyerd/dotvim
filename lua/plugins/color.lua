return {
  {
    "tjdevries/colorbuddy.nvim",

    lazy = false,

    config = function()
      local colorbuddy = require("colorbuddy")
      local colors = colorbuddy.colors
      local Group = colorbuddy.Group

      vim.cmd.colorscheme("gruvbuddy")
      Group.new("ColorColumn", colors.foreground, colors.background:light())
      Group.new("Function", colors.yellow, colors.background)
      Group.new("Typedef", colors.red:light(), colors.background)
      Group.new("Special", colors.purple:light(), colors.background)
    end,
  },
}
