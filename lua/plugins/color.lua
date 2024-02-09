return {
  {
    "tjdevries/gruvbuddy.nvim",

    dependencies = {
      "tjdevries/colorbuddy.vim",
    },

    config = function()
      do
        local colorbuddy = require("colorbuddy")
        local Color, colors, Group, groups, styles = colorbuddy.setup()

        colorbuddy.colorscheme("gruvbuddy")
        Group.new("ColorColumn", colors.foreground, colors.background:light())
      end
    end,
  },
}
