local get_git_root = function ()
  local git_root = vim.fn.system('git rev-parse --show-toplevel'):gsub('\n', '')
  local fail_prefix = 'fatal:'

  if git_root:sub(1, #fail_prefix) == fail_prefix then
    return nil, git_root
  end

  return git_root, 'ok'
end

return get_git_root
