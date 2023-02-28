require("filetype").setup {
  overrides = {
    extensions = {
      nomad = "hcl",
      tf = "terraform",
      tfvars = "terraform",
      tfstate = "json",
    },
  },
}
