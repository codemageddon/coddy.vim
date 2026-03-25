vim.pack.add({ { src = "https://github.com/folke/snacks.nvim" } })
require("snacks").setup({
  picker = { enabled = true },
  lazygit = { enabled = true },
  indent = {
    enabled = true,
    indent = { enabled = false },
    scope = { enabled = true },
  },
  dashboard = {
    enabled = true,
    preset = {
      header = [[
 ██████╗ ██████╗ ██████╗ ██████╗ ██╗   ██╗   ██╗   ██╗██╗███╗   ███╗
██╔════╝██╔═══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝   ██║   ██║██║████╗ ████║
██║     ██║   ██║██║  ██║██║  ██║ ╚████╔╝    ██║   ██║██║██╔████╔██║
██║     ██║   ██║██║  ██║██║  ██║  ╚██╔╝     ╚██╗ ██╔╝██║██║╚██╔╝██║
╚██████╗╚██████╔╝██████╔╝██████╔╝   ██║   ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═════╝ ╚═════╝ ╚═════╝ ╚═════╝   ╚═╝   ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
    },
    sections = {
      { section = "header", padding = 1 },
      { section = "keys", gap = 1, padding = 1 },
      { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1, limit = 20 },
      function()
        local ms = (vim.uv.hrtime() - vim.g.start_time) / 1e6
        local v = vim.version()
        return {
          align = "center",
          text = {
            { "⚡ Neovim loaded in ", hl = "footer" },
            { string.format("%.1fms", ms), hl = "special" },
            { "  " .. tostring(v), hl = "footer" },
          },
        }
      end,
    },
  },
})

if vim.fn.executable("lazygit") == 1 then
  vim.keymap.set("n", "<leader>gg", function()
    Snacks.lazygit({ cwd = Snacks.git.get_root() })
  end, { desc = "Lazygit (Root Dir)" })
  vim.keymap.set("n", "<leader>gG", function()
    Snacks.lazygit()
  end, { desc = "Lazygit (cwd)" })
end
vim.keymap.set("n", "<leader>fb", function()
  Snacks.picker.buffers()
end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fB", function()
  Snacks.picker.buffers({ hidden = true, nofile = true })
end, { desc = "Buffers (all)" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local Snacks = require("snacks")
    local map = function(keys, fn, desc)
      vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = desc })
    end
    map("gd", function()
      Snacks.picker.lsp_definitions()
    end, "LSP: Goto Definition")
    map("gr", function()
      Snacks.picker.lsp_references()
    end, "LSP: References")
    map("gi", function()
      Snacks.picker.lsp_implementations()
    end, "LSP: Implementations")
    map("gt", function()
      Snacks.picker.lsp_type_definitions()
    end, "LSP: Type Definition")
    map("<leader>cs", function()
      Snacks.picker.lsp_symbols()
    end, "LSP: Document Symbols")
  end,
})
