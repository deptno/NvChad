local get_git_remote_info = function (cwd)
  local command = type(cwd) == 'string'
    and string.format("git -C %s remote -v | head -1 | awk '{print $2}'", cwd)
    or "git remote -v | head -1 | awk '{print $2}'"
  local origin = vim.fn.system(command):gsub('\n', '')
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
