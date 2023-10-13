local get_git_remote_info = function ()
  local origin = vim.fn.system([[git remote -v | head -1 | awk '{print $2}']]):gsub('\n', '')
  local fail_prefix = 'fatal:'

  if origin:sub(1, #fail_prefix) == fail_prefix then
    return nil, origin
  end

  local parts = {}

  for part in origin:gmatch("[^@:/]+") do
    table.insert(parts, part)
  end

  local domain = parts[2]
  local username = parts[3]
  local repository = vim.fn.fnamemodify(parts[4], ':r')


  return {
    domain = domain,
    username = username,
    repository = repository,
  }
end

return get_git_remote_info
