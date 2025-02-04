return {
  "nvim-telescope/telescope.nvim",

  branch = "0.1.x",

  dependencies = {
    "nvim-lua/plenary.nvim"
  },

  config = function()
    require("telescope").setup {
      pickers = {
        buffers = {
          mappings = {
            n = {
              ["dd"] = require("telescope.actions").delete_buffer,
            },
          },
        },
      },
    }

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<C-p>", builtin.find_files, {})
    vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
    vim.keymap.set("n", "<leader>ff", builtin.resume, {})
    vim.keymap.set("n", "<leader>f.",
      function() builtin.find_files { hidden = true } end, {})
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    vim.keymap.set("n", "<leader>fl", builtin.current_buffer_fuzzy_find, {})
    vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})
    vim.keymap.set("n", "<leader>ft", builtin.builtin, {})
    vim.keymap.set("n", "<leader>fv",
      function() builtin.find_files { cwd = vim.fn.stdpath("config") } end, {})

    -- Override common LSP bindings.
    vim.keymap.set("n", "gr", builtin.lsp_references, {})
  end
}
