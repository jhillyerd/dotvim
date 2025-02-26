return {
  "akinsho/toggleterm.nvim",

  version = "^2.3.0",

  config = function()
    require("toggleterm").setup({
      open_mapping = "<leader>t",
      insert_mappings = false,
      terminal_mappings = false,

      -- auto_scroll = true,
      direction = "vertical",
      size = 100,

      shell = "fish",
    })
  end
}
