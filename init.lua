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

vim.filetype.add({
  pattern = {
    ['%.gitlab%-ci%.ya?ml'] = 'yaml.gitlab',
  },
})

vim.keymap.set("n", "<leader>cr", function()
  vim.lsp.buf.rename()
end, { desc = "Rename Symbol" })
vim.keymap.set("n", "<leader>ul", "<cmd>set list!<cr>", { desc = "Toggle List Chars" })
vim.keymap.set({ "n", "t" }, "<C-/>", function()
  -- If current window is a terminal, hide it
  if vim.bo.buftype == "terminal" then
    vim.cmd("hide")
    return
  end
  -- Look for an existing terminal window and focus it
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.bo[vim.api.nvim_win_get_buf(win)].buftype == "terminal" then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
  -- Look for a hidden terminal buffer and open it
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" and vim.api.nvim_buf_is_loaded(buf) then
      vim.cmd("botright sbuffer " .. buf)
      return
    end
  end
  -- No terminal exists, create one
  vim.cmd("botright terminal")
end, { desc = "Toggle Terminal" })

vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 170 })
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
})
