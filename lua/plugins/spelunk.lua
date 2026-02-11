return {
  'EvWilson/spelunk.nvim',

  dependencies = {
    'nvim-lua/plenary.nvim',
  },

  config = function()
    -- Layout related functions.
    local margin = function() if vim.o.columns > 120 then return 5 else return 1 end end
    local tenths = function() return math.floor((vim.o.columns - (margin() * 2)) / 10) end
    local height = function() return math.floor(vim.o.lines * 0.75) end
    local bookmark_width = function() return tenths() * 4 end
    local preview_width = function() return tenths() * 6 end

    require('spelunk').setup({
      enable_persist = true,
      base_mappings = {
        toggle = '<Leader><Leader>',
        add = '<Leader>a',
        delete = 'NONE',
        next_bookmark = 'NONE',
        prev_bookmark = 'NONE',
        search_bookmarks = 'NONE',
        search_current_bookmarks = 'NONE',
        search_stacks = 'NONE',
        change_line = 'NONE',
      },
      window_mappings = {
        close = '<Esc>',
        delete_bookmark = 'dd',
      },
      orientation = {
        bookmark_dimensions = function()
          return {
            base = {
              width = bookmark_width(),
              height = height(),
            },
            line = 0,
            -- Window borders are 1 character wide.
            col = margin() + 1,
          }
        end,
        preview_dimensions = function()
          return {
            base = {
              width = preview_width(),
              height = height(),
            },
            line = 0,
            -- Window borders are 1 character wide, account for 3.
            col = margin() + 3 + bookmark_width(),
          }
        end,
        help_dimensions = function()
          return {
            base = {
              width = tenths() * 7,
              height = height() - 4,
            },
            line = 0,
            col = 0,
          }
        end,
      },
    })
  end
}
