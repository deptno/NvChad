local notify_result = vim.schedule_wrap(function (code)
  local chunk = load(code)
  local success, result = pcall(chunk)
  local level = success and vim.log.levels.INFO or vim.log.levels.ERROR

  if type(result) == 'table' then
    result = vim.inspect(result)
  end

  vim.notify(tostring(result), level)
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
do
  %s
end
]], code)

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
