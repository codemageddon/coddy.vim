local Ralphex = {}

Ralphex.defaults = {
  cmd = "ralphex",
  args = {},
  win = {
    style = "ralphex",
  },
}

Ralphex.options = vim.deepcopy(Ralphex.defaults)

function Ralphex.setup(opts)
  Ralphex.options = vim.tbl_deep_extend("force", Ralphex.defaults, opts or {})

  -- Optional command
  vim.api.nvim_create_user_command("Ralphex", function(cmd)
    Ralphex.open({ args = cmd.fargs })
  end, {
    nargs = "*",
    complete = function()
      return {}
    end,
  })
end

function Ralphex.open(opts)
  opts = vim.tbl_deep_extend("force", Ralphex.options, opts or {})

  if vim.fn.executable(opts.cmd) == 0 then
    vim.notify("claude not found on PATH", vim.log.levels.ERROR)
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

Ralphex.setup()
