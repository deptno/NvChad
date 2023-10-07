local get_visual_selection = function ()
  local mode = vim.api.nvim_get_mode().mode

  if mode ~= 'v' and mode ~= 'V' then
    return nil
  end

  local _, start_line, start_column = unpack(vim.fn.getpos('v'))
  local _, end_line, end_column = unpack(vim.fn.getcurpos('v'))

  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  if mode == 'v' then
    if start_column > end_column then
      start_column, end_column = end_column, start_column
    end

    return { start_line - 1, start_column - 1, end_line - 1, end_column }
  elseif mode == 'V' then
    return { start_line - 1, 0, end_line - 1, -1 }
  end

end

local get_visual_selection_text = function ()
  local selection = get_visual_selection()

  if selection then
    local start_line, start_column, end_line, end_column = unpack(selection)

    return vim.api.nvim_buf_get_text(0, start_line, start_column, end_line, end_column, {})
  end
end

return get_visual_selection_text
