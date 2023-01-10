-- TODO use better syntax for sets/calls/cmds

local map_opts = { noremap=true, silent=true }

--
-- Normal mode mappings
--

-- Transpose current word to the right
vim.keymap.set("n", "gl", '"xdiwdwep"xp', map_opts)

-- Format paragraph
vim.keymap.set("n", "Q", "gqip", map_opts)

-- Yank to end of line
vim.keymap.set("n", "Y", "y$", map_opts)

-- Left/right cursor keys navigate in/out of tags
vim.keymap.set("n", "<Left>", "<C-t>", map_opts)
vim.keymap.set("n", "<Right>", "<C-]>", map_opts)

-- Place cursor at start of . command
vim.keymap.set("n", ".", ".`[", map_opts)

-- Window navigation
vim.keymap.set("n", "<M-h>", "<C-w>h", map_opts)
vim.keymap.set("n", "<M-j>", "<C-w>j", map_opts)
vim.keymap.set("n", "<M-k>", "<C-w>k", map_opts)
vim.keymap.set("n", "<M-l>", "<C-w>l", map_opts)

-- Open vertical split, move right
vim.keymap.set("n", "<Leader>v", "<C-w>v<C-w>l", map_opts)

-- Redraw window
vim.keymap.set("n", "<C-l>", ":nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<cr><cr><C-l>", map_opts)

-- Command mappings
vim.keymap.set("n", "<Leader>sl", ":<C-u>set list!<cr>", map_opts)
vim.keymap.set("n", "<Leader>sn", ":<C-u>call ToggleNumber()<cr>", map_opts)
vim.keymap.set("n", "<Leader>sp", ":<C-u>set paste!<cr>", map_opts)
vim.keymap.set("n", "<Leader>sr", ":<C-u>set relativenumber!<cr>", map_opts)
vim.keymap.set("n", "<Leader>ss", ":<C-u>set spell!<cr>", map_opts)
vim.keymap.set("n", "<Leader>q", ":<C-u>call ToggleQFix()<cr>", map_opts)
vim.keymap.set("n", "<Leader>x", ":<C-u>e ~/scratch.md<cr>", map_opts)
vim.keymap.set("n", "<Leader>z", ":<C-u>belowright split | startinsert | terminal fish<cr>", map_opts)
vim.keymap.set("n", "+", ":<C-u>resize +2<cr>", map_opts)
vim.keymap.set("n", "_", ":<C-u>resize -2<cr>", map_opts)

--
-- Insert mode mappings
--

vim.keymap.set("i", "jk", "<ESC>", map_opts)

--
-- Terminal mode mappings
--

vim.keymap.set("t", "jk", "<C-\\><C-N>", map_opts)
vim.keymap.set("t", "<M-h>", "<C-\\><C-N><C-w>h", map_opts)
vim.keymap.set("t", "<M-j>", "<C-\\><C-N><C-w>j", map_opts)
vim.keymap.set("t", "<M-k>", "<C-\\><C-N><C-w>k", map_opts)
vim.keymap.set("t", "<M-l>", "<C-\\><C-N><C-w>l", map_opts)
