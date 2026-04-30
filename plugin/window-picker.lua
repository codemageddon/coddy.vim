vim.pack.add({
  "https://github.com/s1n7ax/nvim-window-picker",
})

require("window-picker").setup()

vim.keymap.set("n", "<leader>wg", function()
  local picked = require("window-picker").pick_window({
    hint = "floating-big-letter",
    filter_rules = {
	  autoselect_one = false,
      bo = {
		filetype = { 'notify', 'snacks_notif' },
		buftype = {},
	  },
    },
  })
  if picked then
    vim.api.nvim_set_current_win(picked)
  end
end, { desc = "Pick window" })
