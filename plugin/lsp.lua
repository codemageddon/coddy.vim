vim.pack.add({ { src = "https://github.com/neovim/nvim-lspconfig" } })

vim.lsp.enable({
  "lua_ls",
  "gitlab-ci-ls",
  "jazz-lsp",
  "tsp-server",
  -- "basedpyright",
  "ty",
  "gopls",
  "rust-analyzer",
  "ruff",
  "jsonls",
  "cssls",
  "clangd",
})
