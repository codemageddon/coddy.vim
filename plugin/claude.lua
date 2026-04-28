local Claude = {}

Claude.defaults = {
  cmd = "claude",
  args = {},
  win = {
    style = "claude",
  },
}

Claude.options = vim.deepcopy(Claude.defaults)

function Claude.setup(opts)
  Claude.options = vim.tbl_deep_extend("force", Claude.defaults, opts or {})

  -- Optional command
  vim.api.nvim_create_user_command("Claude", function(cmd)
    Claude.open({ args = cmd.fargs })
  end, {
    nargs = "*",
    complete = function()
      return {}
    end,
  })
end

function Claude.open(opts)
  opts = vim.tbl_deep_extend("force", Claude.options, opts or {})

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

Claude.setup()
