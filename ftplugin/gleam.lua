local map_opts = { buffer = 0, noremap = true, silent = false }

-- Bidirectional conversion between gleam src and test file paths.
local function alternate_file_path(fname)
  local src_file = string.match(fname, [[^src([/\].*)%.gleam$]])
  if src_file then
    return "test" .. src_file .. "_test.gleam"
  end

  local test_file = string.match(fname, [[^test([/\].*)_test%.gleam$]])
  if test_file then
    return "src" .. test_file .. ".gleam"
  end

  return nil
end

local function alternate_file()
  local path = vim.fn.expand("%")
  local alt = alternate_file_path(path)
  if alt then
    vim.cmd("edit " .. alt)
  else
    vim.notify("Unable to determine alternate file for " .. path, vim.log.levels.WARN)
  end
end

vim.keymap.set("n", "<LocalLeader>a", alternate_file, map_opts)
vim.keymap.set("n", "<LocalLeader>r", "<Cmd>TermExec cmd='gleam run'<cr>", map_opts)
vim.keymap.set("n", "<LocalLeader>t", "<Cmd>TermExec cmd='gleam test'<cr>", map_opts)
