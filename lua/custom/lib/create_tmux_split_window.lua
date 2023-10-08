local is_tmux = type(vim.env.TMUX) == 'string'
local create_tmux_split_window_vertical = function()
  if not is_tmux then
    return vim.notify('Not in tmux',vim.log.levels.ERROR)
  end

  vim.fn.system('tmux split-window -v -c "' .. vim.fn.getcwd() .. '"')
end
local create_tmux_split_window_horizontal = function()
  if not is_tmux then
    return vim.notify('Not in tmux',vim.log.levels.ERROR)
  end

  vim.fn.system('tmux split-window -h -c "' .. vim.fn.getcwd() .. '"')
end

return {
  create_tmux_split_window_horizontal = create_tmux_split_window_horizontal,
  create_tmux_split_window_vertical = create_tmux_split_window_vertical,
}
