local is_tmux = type(vim.env.TMUX) == 'string'
local run_tmux = function(args)
  if not is_tmux then
    return vim.notify('Not in tmux',vim.log.levels.ERROR)
  end

  local direction = string.format('-%s', args.direction)
  local wd = string.format('-c %s', args.wd or vim.fn.getcwd())
  local sh = args.sh and string.format('$(SHELL) "%s"', args.sh) or ''
  local command = string.format('tmux split-window %s %s %s', direction, wd, sh)

  vim.notify(command, vim.log.levels.TRACE)

  return vim.fn.system(command)
end

---
---tmux split-window -v
---
---@param args?  table
---  - `wd` (string = cwd): working directory
---  - `sh` (string = ""): tmux panel 에서 사용될 shell 명령어
local create_tmux_split_window_vertical = function(args)
  return run_tmux(vim.tbl_extend('keep', { direction = 'v' }, args or {}))
end
---
---tmux split-window -h
---
---@param args?  table
---  - `wd` (string = cwd): working directory
---  - `sh` (string = ""): tmux panel 에서 사용될 shell 명령어
local create_tmux_split_window_horizontal = function(args)
  return run_tmux(vim.tbl_extend('keep', { direction = 'h' }, args or {}))
end

return {
  create_tmux_split_window_horizontal = create_tmux_split_window_horizontal,
  create_tmux_split_window_vertical = create_tmux_split_window_vertical,
}
