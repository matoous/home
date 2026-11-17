-- Global Rex configuration, managed by the dotfiles repository.

for _, appearance in ipairs({ "Dark", "Light" }) do
  local variant = appearance:lower()
  rex.action{
    name = "import_warm_burnout_" .. variant,
    title = "Import Warm Burnout " .. appearance,
    category = "View",
    run = function()
      local home = assert(os.getenv("HOME"), "HOME is unavailable")
      rex.client.queue("client.theme.import", {
        path = home .. "/.config/rex/themes/warm-burnout-" .. variant,
      })
    end,
  }
end

-- Split and maximize panes.
rex.bind("cmd+d", "pane.split", { direction = "right" })
rex.bind("cmd+shift+d", "pane.split", { direction = "down" })
rex.bind("cmd+shift+enter", "pane.zoom")

-- Move between panes.
rex.bind("cmd+alt+h", "pane.focus", { direction = "left" })
rex.bind("cmd+alt+j", "pane.focus", { direction = "down" })
rex.bind("cmd+alt+k", "pane.focus", { direction = "up" })
rex.bind("cmd+alt+l", "pane.focus", { direction = "right" })

local terminal = "com.superlogical.terminal"
local fish = "/opt/homebrew/bin/fish"

local function checked(result, err)
  if result == nil then error(err or "Rex request failed", 0) end
  return result
end

local function directory(ctx)
  local result = checked(rex.block.call(terminal, "pwd", { block_id = ctx.block_id }))
  local path = result.pwd or ""
  if path:match("^file://") then
    path = path:match("^file://[^/]*(/.*)$") or ""
    path = path:gsub("%%(%x%x)", function(hex)
      return string.char(tonumber(hex, 16))
    end)
  end
  if path:sub(1, 1) ~= "/" then
    error("The current pane has not reported an absolute working directory", 0)
  end
  return path
end

local function pane(cwd, command, keep_open)
  return rex.layout.block{
    flavor = terminal .. ".shell",
    options = {
      cwd = cwd,
      shell = fish,
      command = command,
      exit = keep_open and { on_completion = false } or nil,
    },
  }
end

rex.action{
  name = "dev",
  title = "Open Development Layout",
  description = "Open Mitos, Fish, and Codex in the current directory.",
  run = function(ctx)
    local cwd = directory(ctx)
    return checked(rex.session.new_window{
      window_label = "Dev",
      layout = rex.layout.horizontal(0.6,
        pane(cwd, { fish, "-ic", "ms ." }),
        rex.layout.vertical(0.5,
          pane(cwd),
          pane(cwd, { fish, "-ic", "codex" }, true))),
    })
  end,
}

rex.action{
  name = "ask",
  title = "Ask Codex",
  description = "Open Codex beside the current pane with a prompt.",
  args = { prompt = "string", cwd = "string?" },
  run = function(ctx, args)
    if not args.prompt:match("%S") then error("Supply a prompt", 0) end
    local cwd = args.cwd or directory(ctx)
    return checked(rex.session.new_split{
      anchor_id = ctx.block_id,
      direction = "horizontal",
      side = "after",
      ratio = 0.5,
      focus = true,
      layout = pane(cwd, { "codex", "--cd", cwd, "--", args.prompt }),
    })
  end,
}

rex.action{
  name = "diff",
  title = "Open Git Diff",
  description = "Show tracked changes against HEAD, or only staged changes.",
  args = { staged = "boolean?" },
  run = function(ctx, args)
    return checked(rex.session.new_window{
      window_label = "Diff",
      layout = pane(directory(ctx), {
        "git", "-c", "core.fsmonitor=false", "--no-pager", "diff",
        "--color=always", args.staged and "--cached" or "HEAD",
      }, true),
    })
  end,
}

rex.action{
  name = "test",
  title = "Run Tests",
  description = "Run a Fish command below the current pane and keep its output.",
  args = { command = "string" },
  run = function(ctx, args)
    if not args.command:match("%S") then error("Supply a test command", 0) end
    return checked(rex.session.new_split{
      anchor_id = ctx.block_id,
      direction = "vertical",
      side = "after",
      ratio = 0.65,
      focus = true,
      layout = pane(directory(ctx), { fish, "-ic", args.command }, true),
    })
  end,
}
