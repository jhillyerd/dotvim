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
      persist_mode = false, -- Breaks insert mapping.

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

    -- Keymap to jump to current toggleterm buffer and enter insert mode.
    vim.keymap.set("n", "<Leader>ti", function()
      -- List current buffers.
      local buffers = vim.api.nvim_list_bufs()

      -- Check if toggleterm buffer exists.
      local toggleterm_bufnr = false
      for _, buf in ipairs(buffers) do
        local buf_name = vim.api.nvim_buf_get_name(buf)
        if buf_name:find("toggleterm#") then
          toggleterm_bufnr = buf
          break
        end
      end

      local toggleterm_winid = false
      if toggleterm_bufnr then
        -- Find toggleterm window.
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_buf(win) == toggleterm_bufnr then
            toggleterm_winid = win
            break
          end
        end
      end

      -- Switch to toggleterm window, or start new one.
      if toggleterm_winid then
        vim.api.nvim_set_current_win(toggleterm_winid)
        vim.cmd("startinsert!")
      else
        vim.cmd([[ exe 1 . "ToggleTerm" ]])
      end
    end)
  end
}
