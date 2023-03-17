local null_ls = require "null-ls"
local b = null_ls.builtins

null_ls.setup {
  on_attach = LSP_ON_ATTACH,
  sources = {
    b.diagnostics.ruff,
    b.formatting.black,
    b.formatting.terraform_fmt,
  },
}
