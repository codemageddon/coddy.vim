vim.pack.add({ {
  src = "https://github.com/catppuccin/nvim",
  name = "catppuccin",
  version = vim.version.range("^1.11"),
} })
require("catppuccin").setup({
  integrations = {
    neotree = true,
    blink_cmp = {
      style = "bordered",
    },
    snacks = {
      enabled = false,
      indent_scope_color = "lavender",
    },
    lsp_trouble = true,
    which_key = true,
  },
})
vim.cmd.colorscheme("catppuccin-mocha")
