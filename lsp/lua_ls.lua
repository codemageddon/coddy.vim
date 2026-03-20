local library = { vim.env.VIMRUNTIME }
for _, rtp in ipairs(vim.api.nvim_list_runtime_paths()) do
  local lua_dir = rtp .. "/lua"
  if vim.uv.fs_stat(lua_dir) then
    library[#library + 1] = lua_dir
  end
end

return {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { library = library },
      completion = {
        enable = true,
      },
      diagnostics = {
        enable = true,
        globals = { "vim", "Snacks" },
      },
    },
  },
}
