local function create_toggle_to_fit_width()
  -- buf_cache 대신 nvim_buf_set_var 를 이용할 수 있을지
  local buf_cache = {}

  return function()
    local bufnr = vim.fn.bufnr()
    local lines = vim.fn.getbufline(bufnr, 1, '$')
    local width = 30 -- minimum width

    for _, v in ipairs(lines) do
      local line_width = vim.fn.strdisplaywidth(v)
      if line_width > width then
        width = line_width
      end
    end

    local current_width = vim.api.nvim_win_get_width(0)

      print(vim.inspect(buf_cache))
    if
      current_width == width
      and buf_cache[bufnr]
      and buf_cache[bufnr] ~= current_width
    then
      vim.api.nvim_win_set_width(0, buf_cache[bufnr])
    else
      buf_cache[bufnr] = current_width
      vim.api.nvim_win_set_width(0, width)
    end
  end
end

return create_toggle_to_fit_width
