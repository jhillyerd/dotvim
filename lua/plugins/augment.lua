local map_opts = { noremap = true, silent = true }

return {
  "augmentcode/augment.vim",
  init = function()
    vim.g.augment_workspace_folders = { "." }
    vim.g.augment_disable_tab_mapping = true
    vim.keymap.set("n", "<Leader>cc", ":Augment chat<cr>", map_opts)
    vim.keymap.set("n", "<Leader>ct", ":Augment chat-toggle<cr>", map_opts)
    vim.keymap.set("i", "<Right>", '<Cmd>call augment#Accept("\\<Right>")<cr>', map_opts)

    vim.api.nvim_create_autocmd("ColorScheme", {
      -- Current colorscheme name.
      pattern = "nightfox",
      callback = function()
        vim.api.nvim_set_hl(0, "AugmentSuggestionHighlight", {
          fg = "#886088",
          ctermfg = "darkmagenta",
          force = true
        })
      end
    })
  end,
}
