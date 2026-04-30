vim.pack.add({
  "https://github.com/s1n7ax/nvim-window-picker",
})

require("window-picker").setup()

vim.keymap.set("n", "<leader>wp", function()
  local picked = require("window-picker").pick_window()
  if picked then
    vim.api.nvim_set_current_win(picked)
  end
end, { desc = "Pick window" })
