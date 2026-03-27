vim.pack.add({ { src = "https://github.com/stevearc/conform.nvim" } })
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format", "ruff_organize_imports" },
    go = { "goimports", "gci", "gofumpt", "golines" },
    rust = { "rustfmt", lsp_format = "fallback" },
    json = { "jq" },
    css = { "prettier" },
    yaml = { "prettier" },
  },
  formatters = {
    goimports = {
      args = { "-srcdir", "$FILENAME" },
    },
    gci = {
      args = {
        "write",
        "--skip-generated",
        "-s",
        "standard",
        "-s",
        "default",
        "--skip-vendor",
        "$FILENAME",
      },
    },
    gofumpt = {
      prepend_args = { "-extra", "-w", "$FILENAME" },
      stdin = false,
    },
    golines = {
      prepend_args = {
        "--base-formatter=gofumpt",
        "--ignore-generated",
        "--tab-len=1",
        "--max-len=120",
      },
    },
  },
})

vim.keymap.set("n", "<leader>cf", function()
  require("conform").format({ lsp_fallback = true })
end, { noremap = true, silent = true, desc = "Format" })
