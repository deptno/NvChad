local get_git_root= require('lab/gx/lib/get_git_root')
local get_visual_selection = require('custom.lib.get_visual_selection')
local handler = function(lines, matched)
  local git_root = get_git_root()
  local file_path = vim.fn.expand('%:p'):gsub(git_root .. '/', '')
  local origin = vim.fn.system([[git remote -v | head -1 | awk '{print $2}']]):gsub('\n', '')
  local sha1 = vim.fn.system([[git rev-parse @]]):gsub('\n', '')

  local parts = {}

  for part in origin:gmatch("[^@:/]+") do
    table.insert(parts, part)
  end

  local domain = parts[2]
  local username = parts[3]
  local repository = vim.fn.fnamemodify(parts[4], ':r')

  local Job = require("plenary.job")
  local command = "open"
  local range = get_visual_selection()
  local url

  if range and range[1] then
    if range[3] and range[1] ~= range[3] then
      url = string.format("https://%s/%s/%s/blob/%s/%s#L%s-L%s", domain, username, repository, sha1, file_path, range[1] + 1, range[3] + 1)
    else
      url = string.format("https://%s/%s/%s/blob/%s/%s#L%s", domain, username, repository, sha1, file_path, range[1] + 1)
    end
  else
    url = string.format("https://%s/%s/%s/blob/%s/%s", domain, username, repository, sha1, file_path)
  end

  Job:new({
    command,
    args = {
      url,
    },
  }):sync()

  vim.notify(string.format("Open github permalink: %s", sha1), vim.log.levels.INFO)
end
local match = function(lines)
  vim.notify(tostring(get_git_root()))
  return get_git_root()
end
local name = 'github commit file permalink'

return {
  handler = handler,
  match = match,
  name = name,
}
