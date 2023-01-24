require('telescope').setup {
  pickers = {
    buffers = {
      mappings = {
        n = {
          ["dd"] = require('telescope.actions').delete_buffer,
        },
      },
    },
  },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fl', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
