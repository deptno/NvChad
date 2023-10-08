local notify_result = vim.schedule_wrap(function (code)
  local chunk = load(code)
  local success, result = pcall(chunk)

  if type(result) == 'table' then
    result = tostring(vim.inspect(result))
  end

  if success then
    vim.notify(result, vim.log.levels.INFO)
  else
    vim.notify(result, vim.log.levels.ERROR)
  end
end)

local run_code = vim.schedule_wrap(
  function(title, code)
    vim.notify(code, vim.log.levels.INFO, {
      title = title,
      on_open = function (win)
        local buf = vim.api.nvim_win_get_buf(win)
        local filetype = vim.bo.filetype

        vim.api.nvim_buf_set_option(buf, "filetype", filetype)

        local sandbox = string.format([[
local runner = function()
  %s
end
return runner()]], code)

        notify_result(sandbox)
      end
    })
  end
)

local run = function (code)
  run_code('Run', code)
end
local evaluate = function (code)
  run_code('Evaluate', code)
end

return {
  run = run,
  evaluate = evaluate,
}
