return {
  cmd = { "pyright-langserver", "--stdio" },
  settings = {
    pyright = {
      typeChckingMode = "standard",
      disableOrganizeImports = true,
    },
  },
  filetypes = { "python" },
}
