local map = require("custom/lib/map")
local handler = function(lines, matched)
  local Job = require("plenary.job")
  local command = "open"
  local url = string.format('https://papago.naver.com/?sk=en&tk=ko&hn=1&st=%s', matched)

  Job:new({
    command,
    args = {
      url,
    },
  }):sync()

  vim.notify(string.format("Open papago: %s", matched), vim.log.levels.INFO)
end
---trim string
---@param text string
---@return string
local trim = function(text)
  return text:match([[^%s*(.-)%s*$]])
end
local match = function (lines)
  for _, line in ipairs(lines) do
    if line:gmatch('%w+') then
      return trim(table.concat(map(trim, lines), ' '))
    end
  end

  return nil
end
local name = 'translator:papago'

return {
  handler = handler,
  match = match,
  name = name,
}
