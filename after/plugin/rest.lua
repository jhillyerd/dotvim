local map_opts = { buffer = 0, noremap = true, silent = false }

local ok, rest = pcall(require, "rest-nvim")
if ok then
  rest.setup({})

  local group = vim.api.nvim_create_augroup('rest-nvim', { clear = true })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = "http",
    group = group,
    callback = function()
      vim.keymap.set("n", "<LocalLeader>r", "<Plug>RestNvim", map_opts)
    end,
  })
end
