local trim_spaces = true
local set_opfunc = vim.fn[vim.api.nvim_exec([[
  func s:set_opfunc(val)
    let &opfunc = a:val
  endfunc
  echon get(function('s:set_opfunc'), 'name')
]], true)]

return {
  "akinsho/toggleterm.nvim",

  version = "^2.13.0",

  config = function()
    require("toggleterm").setup({
      open_mapping = "<Leader>tt",
      insert_mappings = false,
      terminal_mappings = false,

      -- auto_scroll = true,
      direction = "horizontal",
      size = 25,

      shell = "fish",
    })

    vim.keymap.set("n", "<Leader>ts", function()
      require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
    end)
    vim.keymap.set("v", "<Leader>ts", function()
      require("toggleterm").send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })
    end)
    -- Send entire buffer.
    vim.keymap.set("n", "<Leader>tf", function()
      set_opfunc(function(motion_type)
        require("toggleterm").send_lines_to_terminal(motion_type, false, { args = vim.v.count })
      end)
      vim.api.nvim_feedkeys("ggg@G''", "n", false)
    end)
    -- Send paragraph.
    vim.keymap.set("n", "<Leader>tp", function()
      set_opfunc(function(motion_type)
        require("toggleterm").send_lines_to_terminal(motion_type, false, { args = vim.v.count })
      end)
      vim.api.nvim_feedkeys("g@ap", "n", false)
    end)
  end
}
