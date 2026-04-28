local Revdiff = {}

Revdiff.defaults = {
  cmd = "revdiff",
  args = {},
  win = {
    style = "revdiff",
  },
  defaults = {"--wrap"}
}

Revdiff.options = vim.deepcopy(Revdiff.defaults)

function Revdiff.setup(opts)
  Revdiff.options = vim.tbl_deep_extend("force", Revdiff.defaults, opts or {})

  -- Optional command
  vim.api.nvim_create_user_command("Revdiff", function(cmd)
    Revdiff.open({ args = cmd.fargs })
  end, {
    nargs = "*",
    complete = function()
      return { "main", "HEAD~1", "HEAD~3", "--all-files" }
    end,
  })
end

function Revdiff.open(opts)
  opts = vim.tbl_deep_extend("force", Revdiff.options, opts or {})

  if vim.fn.executable(opts.cmd) == 0 then
    vim.notify("revdiff not found on PATH", vim.log.levels.ERROR)
    return
  end

  local args = opts.args or {}
  local command = vim.list_extend({ opts.cmd }, args)

  require("snacks").terminal(command, {
    win = opts.win,
    cwd = opts.cwd or vim.fn.getcwd(),
    env = opts.env,
  })
end

Revdiff.setup()
