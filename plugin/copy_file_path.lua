vim.api.nvim_create_user_command("CopyRelPath", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  vim.notify("Copied `" .. path .. "` to the clipboard")
end, {})

vim.api.nvim_create_user_command("CopyAbsPath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied `" .. path .. "` to the clipboard")
end, {})

vim.keymap.set(
  "n",
  "<leader>by",
  "<cmd>CopyRelPath<cr>",
  { desc = "Copy current buffer relative path" }
)
vim.keymap.set(
  "n",
  "<leader>bY",
  "<cmd>CopyAbsPath<cr>",
  { desc = "Copy current buffer absolute path" }
)
