vim.pack.add({ { src = "https://github.com/neovim/nvim-lspconfig" } })

do
  local lua_ls_library = { vim.env.VIMRUNTIME }
  for _, rtp in ipairs(vim.api.nvim_list_runtime_paths()) do
    local lua_dir = rtp .. "/lua"
    if vim.uv.fs_stat(lua_dir) then
      lua_ls_library[#lua_ls_library + 1] = lua_dir
    end
  end
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = { library = lua_ls_library },
        completion = {
          enable = true,
        },
        diagnostics = {
          enable = true,
          globals = { "vim" },
        },
      },
    },
  })
end
vim.lsp.enable({ "lua_ls" })

vim.lsp.config("jazz-lsp", {
  mason = false,
  cmd = { "/Users/s_tsaplin/gitlab.rnd.wargaming.net/jazz/jazz/target/release/jazz-lsp" },
  filetypes = { "json", "yaml" },
  root_markers = { "schema", "jazz-schema.toml" },
})
vim.lsp.enable("jazz-lsp")

vim.lsp.config("tsp-server", {
  mason = false,
  cmd = { "tsp-server", "--stdio" },
  filetypes = { "typespec", "tsp" },
})
vim.lsp.enable("tsp-server")

vim.lsp.config("basedpyright", {
  cmd = { "basedpyright-langserver", "--stdio" },
  settings = {
    basedpyright = {
      typeCheckingMode = "standard",
      disableOrganizeImports = true,
    },
  },
  filetypes = { "python" },
})
vim.lsp.enable("basedpyright")


vim.lsp.config("gopls", {
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
      semanticTokens = true,
    },
  },
})
vim.lsp.enable("gopls")

vim.lsp.config("rust-analyzer", {
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
})
vim.lsp.enable("rust-analyzer")

vim.lsp.config("ruff", {})
vim.lsp.enable("ruff")

vim.lsp.config("jsonls", {
  settings = {
    json = {
      format = {
        enable = true,
      },
    },
    validate = {
      enable = true,
    },
  },
})
vim.lsp.enable("jsonls")

vim.lsp.config("cssls", {
  settings = {
    css = {
      format = {
        enable = true,
      },
    },
    validate = {
      enable = true,
    },
  },
})
