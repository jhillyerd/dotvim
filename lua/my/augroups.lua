local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

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
