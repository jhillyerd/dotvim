local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local map_opts = { buffer=0, noremap=true, silent=true }

-- Global autocmds
do
  local group = augroup("vimrc", {})

  autocmd("FileType", {
    pattern = { "markdown", "text" },
    callback = function()
      vim.keymap.set(
        "n", "<LocalLeader>f", ":<C-u>normal! mm[s1z=`m<cr>", map_opts)
    end,
    group = group,
  })
end

-- Terminal autocmds
do
  local group = augroup("vimrcterm", {})

  autocmd("TermOpen", {
    pattern = "*",
    callback = function()
      vim.opt.number = false
      vim.opt.relativenumber = false
    end,
    group = group,
  })

  autocmd("TermClose", {
    pattern = "term://*fish",
    callback = function()
      vim.cmd("close")
    end,
    group = group,
  })

  autocmd("BufEnter", {
    pattern = "term://*fish",
    callback = function()
      vim.cmd("startinsert")
    end,
    group = group,
  })
end
