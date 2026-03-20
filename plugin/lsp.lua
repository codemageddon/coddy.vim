vim.pack.add({ { src = "https://github.com/neovim/nvim-lspconfig" } })

vim.lsp.enable({
  "lua_ls",
  "jazz-lsp",
  "tsp-server",
  "basedpyright",
  "gopls",
  "rust-analyzer",
  "ruff",
  "jsonls",
  "cssls",
})
