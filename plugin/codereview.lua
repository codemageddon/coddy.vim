vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/afewyards/codereview.nvim",
})

require("codereview").setup({})

vim.keymap.set("n", "<leader>cmr", "<cmd>CodeReview<cr>", { desc = "Code Review" })
