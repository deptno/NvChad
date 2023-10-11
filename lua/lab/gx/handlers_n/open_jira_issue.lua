local open_jira_issue = function(line)
  -- B2C-34000
  local matched = string.match(line, "B2C%-%d+")

  if matched then
    local Job = require("plenary.job")
    local command = "open"

    Job:new({
      command,
      args = {
        "https://zigbang.atlassian.net/browse/" .. matched
      },
    }):sync()

    vim.notify(string.format("Open ticket: %s", matched), vim.log.levels.INFO)
  end

  return matched
end

return open_jira_issue
