# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Neovim configuration using the built-in `vim.pack` package manager (not lazy.nvim or packer). Uses `NVIM_APPNAME=nvim12`, so data lives in `~/.local/share/nvim12/`.

## Architecture

Config is split across `init.lua` and `plugin/` directory. Neovim auto-sources all files in `plugin/` alphabetically during startup.

- **`init.lua`** — leader key, options, global keymaps, autocommands. No plugin code.
- **`plugin/`** — one file per plugin, each self-contained: `vim.pack.add()` + `setup()` + keymaps together.
  - `00-catppuccin.lua` — prefixed to load colorscheme first (alphabetical order matters).
  - `lsp.lua` — all `vim.lsp.config()` / `vim.lsp.enable()` calls. LSP tools are installed via mise, not mason.
  - `snacks.lua` — picker, lazygit, indent, dashboard. Also has `LspAttach` autocmd for LSP navigation keymaps via Snacks picker.
  - `neo-tree.lua` — includes dependency plugins (plenary, nui, devicons) in a single `vim.pack.add()` call, plus snacks rename integration.

## Key conventions

- `vim.pack.add()` expects an **array of specs**: `vim.pack.add({ { src = "..." } })`, not `vim.pack.add({ src = "..." })`.
- Lock file: `nvim-pack-lock.json`.
- `vim.g.start_time` is set in `init.lua` and read by `plugin/snacks.lua` for the dashboard startup timer.
- Formatting is handled by conform.nvim (not LSP formatting). StyLua for Lua, ruff for Python, goimports+gci+gofumpt+golines for Go, rustfmt for Rust.

## Formatting

Lua files are formatted with StyLua: `stylua --indent-type Spaces --indent-width 2 --column-width 120`.
