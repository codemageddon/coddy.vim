return {
  cmd = { "basedpyright-langserver", "--stdio" },
  settings = {
    basedpyright = {
      typeCheckingMode = "standard",
      disableOrganizeImports = true,
    },
  },
  filetypes = { "python" },
}
