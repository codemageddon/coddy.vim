return {
  cmd = { "/opt/homebrew/bin/rust-analyzer" },
  root_markers = { "Cargo.toml" },
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true,
      },
    },
  },
  filetypes = { "rust" },
}
