local Revdiff = {}

Revdiff.defaults = {
  cmd = "revdiff",
  args = {},
  win = {
    style = "revdiff",
  },
  defaults = { "--wrap" },
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

local function show_annotations(lines)
  vim.cmd("vsplit")
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_win_set_buf(0, buf)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  pcall(vim.api.nvim_buf_set_name, buf, "revdiff://annotations-" .. vim.uv.hrtime())
  vim.bo[buf].filetype = "markdown"
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].modified = false
end

function Revdiff.open(opts)
  opts = vim.tbl_deep_extend("force", Revdiff.options, opts or {})

  if vim.fn.executable(opts.cmd) == 0 then
    vim.notify("revdiff not found on PATH", vim.log.levels.ERROR)
    return
  end

  local output_file = vim.fn.tempname()
  -- pre-create so filereadable() is deterministic; revdiff overwrites
  local fh = io.open(output_file, "w")
  if fh then
    fh:close()
  end

  local command = vim.list_extend({ opts.cmd, "--output=" .. output_file }, opts.args or {})

  local win = require("snacks").win(vim.tbl_deep_extend("force", {
    style = "revdiff",
    position = "float",
    border = "rounded",
    width = 0.9,
    height = 0.9,
    enter = true,
    bo = { filetype = "snacks_terminal" },
    keys = { term_normal = false },
  }, opts.win or {}))

  local function finalize(exit_code)
    if win:valid() then
      win:close()
    end

    local lines = {}
    if vim.fn.filereadable(output_file) == 1 then
      lines = vim.fn.readfile(output_file)
    end
    vim.fn.delete(output_file)

    if exit_code ~= 0 then
      vim.notify("revdiff: exited with code " .. exit_code, vim.log.levels.WARN)
      return
    end

    if #lines == 0 or (#lines == 1 and lines[1] == "") then
      vim.notify("revdiff: no annotations", vim.log.levels.INFO)
      return
    end

    show_annotations(lines)
  end

  vim.api.nvim_buf_call(win.buf, function()
    vim.fn.jobstart(command, {
      term = true,
      cwd = opts.cwd or vim.fn.getcwd(),
      env = opts.env,
      on_exit = function(_, exit_code)
        vim.schedule(function()
          finalize(exit_code)
        end)
      end,
    })
  end)
  vim.cmd.startinsert()
end

Revdiff.setup()
