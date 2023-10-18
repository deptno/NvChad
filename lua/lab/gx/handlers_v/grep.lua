local trim = require("custom/lib/trim")
local handler = function(lines, matched)
  if not pcall(require, 'telescope') then
    return vim.notify('fail to require "telescope"')
  end

  vim.cmd(':Telescope live_grep default_text=' .. matched)
end
local match = function (lines)
  if #lines == 1 then
    local line = lines[1]

    if line:gmatch('%w+') then
      return trim(line)
    end
  end

  return nil
end
local name = 'grep text'

return {
  handler = handler,
  match = match,
  name = name,
}
