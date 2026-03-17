vim.pack.add({
  "https://github.com/FabijanZulj/blame.nvim",
})

require("blame").setup()

vim.keymap.set("n", "<leader>gb", "<cmd>BlameToggle<cr>", { desc = "Git blame" })
