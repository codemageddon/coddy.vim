vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  {
    src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
    version = vim.version.range("3"),
  },
})
local function on_move(data)
  Snacks.rename.on_rename_file(data.source, data.destination)
end
local events = require("neo-tree.events")
require("neo-tree").setup({
  event_handlers = {
    { event = events.FILE_MOVED, handler = on_move },
    { event = events.FILE_RENAMED, handler = on_move },
  },
  window = {
    mappings = {
      ["h"] = "close_node",
      ["l"] = "open",
    },
  },
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Explorer" })
