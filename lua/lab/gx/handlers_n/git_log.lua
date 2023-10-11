local handler = function(line, matched)
end
local match = function(line)
  return false
end
local name = 'git_log'

return {
  handler = handler,
  match = match,
  name = name,
}
