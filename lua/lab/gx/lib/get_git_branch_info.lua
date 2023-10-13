local get_git_branch_info = function ()
  local ret = vim.fn.system([[git branch -vv | grep -e '^*' | awk '{ print $2 " -> " $4 }']]):gsub('\n', '')
  local fail_prefix = 'fatal:'

  if ret:sub(1, #fail_prefix) == fail_prefix then
    return nil, ret
  end

  return ret, 'ok'
end

return get_git_branch_info
