local handler = function(line, matched)
  local Job = require("plenary.job")
  local command = "open"

  Job:new({
    command,
    args = {
      "https://zigbang.atlassian.net/browse/" .. matched
    },
  }):sync()

  vim.notify(string.format("Open github commit: %s", matched), vim.log.levels.INFO)
end
local match = function(line)
  return true
end
local name = 'github_commit'

return {
  handler = handler,
  match = match,
  name = name,
}
