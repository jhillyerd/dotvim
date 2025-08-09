return {
  'EvWilson/spelunk.nvim',

  dependencies = {
    'nvim-lua/plenary.nvim',
  },

  config = function()
    require('spelunk').setup({
      enable_persist = true,
      base_mappings = {
        toggle = '<Leader><Leader>',
        add = '<Leader>a',
        next_bookmark = 'NONE',
        prev_bookmark = 'NONE',
        search_bookmarks = 'NONE',
        search_current_bookmarks = 'NONE',
        search_stacks = 'NONE',
      },
      window_mappings = {
        close = '<Esc>',
        delete_bookmark = 'dd',
      },
    })
  end
}
