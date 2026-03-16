# coddy.vim

Personal Neovim configuration using the built-in `vim.pack` package manager.

## Requirements

- Neovim 0.12+ (uses `vim.pack`)
- [mise](https://mise.jdx.dev/) for tool management (LSP servers, formatters)
- [Nerd Font](https://www.nerdfonts.com/) for icons
- [lazygit](https://github.com/jesseduffield/lazygit) (optional, for git UI)
- [fzf](https://github.com/junegunn/fzf) (for fuzzy finding)

## Usage

```sh
NVIM_APPNAME=nvim12 nvim
```

## Structure

```
init.lua              Global options, leader key, keymaps, autocommands
stylua.toml           StyLua formatter config
plugin/
  00-catppuccin.lua   Colorscheme (loaded first)
  blink.lua           Completion (LSP-only sources)
  conform.lua         Formatting (stylua, ruff, gofumpt, rustfmt, etc.)
  fzf-lua.lua         Fuzzy finder
  lsp.lua             LSP server configs
  lualine.lua         Statusline
  neo-tree.lua        File explorer
  snacks.lua          Picker, lazygit, indent, dashboard
  treesitter.lua      Syntax highlighting
  trouble.lua         Diagnostics list
  which-key.lua       Keybinding hints
```

Each plugin file is self-contained: package registration, setup, and keymaps live together. Neovim auto-sources `plugin/` files alphabetically on startup.

## Plugins

| Plugin | Purpose |
|--------|---------|
| [catppuccin](https://github.com/catppuccin/nvim) | Colorscheme (mocha) |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configurations |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [blink.cmp](https://github.com/saghen/blink.cmp) | Completion |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting |
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | Fuzzy finder |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | Picker, lazygit, indent guides, dashboard |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding hints |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |

## LSP Servers

All installed via mise (not mason):

- **lua_ls** — Lua
- **basedpyright** + **ruff** — Python
- **gopls** — Go
- **rust-analyzer** — Rust
- **jsonls** — JSON
- **cssls** — CSS
- **jazz-lsp** — Jazz (custom)
- **tsp-server** — TypeSpec

## Key Bindings

Leader key: `Space`

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `<leader><leader>` | Find files |
| `<leader>/` | Live grep |
| `<leader>sf` | Format buffer |
| `<leader>cr` | Rename symbol |
| `<leader>ul` | Toggle list chars |
| `<leader>gg` | Lazygit (git root) |
| `<leader>gG` | Lazygit (cwd) |
| `<leader>fb` | Buffers |
| `<leader>xx` | Diagnostics |
| `<leader>xX` | Buffer diagnostics |
| `<leader>xs` | Symbols |
| `<leader>xq` | Quickfix list |
| `gd` | Go to definition |
| `gr` | References |
| `gi` | Implementations |
| `gt` | Type definition |
| `<leader>cs` | Document symbols |
