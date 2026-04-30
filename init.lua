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
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH
if vim.fn.has("win32") == 1 then
    vim.o.shell = "pwsh"
    vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
    vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    vim.o.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
    vim.o.shellquote = ""
    vim.o.shellxquote = ""
end

vim.filetype.add({
  pattern = {
    ["%.gitlab%-ci%.ya?ml"] = "yaml.gitlab",
  },
})

vim.keymap.set("n", "<leader>cr", function()
  vim.lsp.buf.rename()
end, { desc = "Rename Symbol" })
vim.keymap.set("n", "<leader>ul", "<cmd>set list!<cr>", { desc = "Toggle List Chars" })
vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 170 })
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
})
vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle<cr>", { desc = "Symbols" })

vim.keymap.set({ "n", "t" }, "<c-/>", function()
  Snacks.terminal.focus(nil, {})
end, { desc = "Terminal (cwd)" })
