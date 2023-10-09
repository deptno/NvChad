local constant = require('custom/lib/constant')

local function notify(title)
  vim.notify(
    vim.fn.fnamemodify(vim.fn.getcwd(), ':~'),
    vim.log.levels.INFO,
    { title = title }
  )
end
local function cd(path)
  local current_session = vim.fs.basename(vim.fn.resolve(constant.PREVIOUS_SESSION_LINK_PATH))

  if path then
    vim.api.nvim_set_current_dir(path)
    notify(string.format('(%s) cd', tostring(current_session)))
  else
    notify(string.format('(%s) cwd', tostring(current_session)))
  end
end

return cd
