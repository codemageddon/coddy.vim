vim.g.start_time = vim.uv.hrtime()
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.colorcolumn = "100"
vim.opt.list = false
vim.opt.listchars = { tab = "→ ", multispace = "·", eol = "󰌑" }
vim.opt.winborder = "rounded"
vim.opt.clipboard = "unnamedplus"
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH


vim.keymap.set("n", "<leader>cr", function()
  vim.lsp.buf.rename()
end, { desc = "Rename Symbol" })
vim.keymap.set("n", "<leader>ul", "<cmd>set list!<cr>", { desc = "Toggle List Chars" })
vim.keymap.set({ "n", "t" }, "<C-/>", function()
  vim.cmd("botright terminal")
end, { desc = "Open Terminal" })

vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 170 })
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
})
