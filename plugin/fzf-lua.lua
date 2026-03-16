vim.pack.add({ { src = "https://github.com/ibhagwan/fzf-lua" } })
local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader><leader>", fzf.files, { desc = "Files" })
vim.keymap.set("n", "<leader>/", fzf.live_grep, { desc = "Live Grep" })
