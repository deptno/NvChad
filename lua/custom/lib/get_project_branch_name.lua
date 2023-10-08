local get_project_branch_name = function()
  local project_root_path = vim.fn.system('git rev-parse --show-toplevel'):gsub('\n', '')
  if not project_root_path then
    return vim.notify('not git_root', vim.log.levels.TRACE)
  end

  local current_branch = vim.fn.system('git branch --show-current')
  if not current_branch then
    return vim.notify('not current_branch', vim.log.levels.TRACE)
  end

  local directory_path = vim.fs.dirname(vim.fn.fnamemodify(project_root_path, ':~'))

  local first = true
  local directory_prefix = ''

  for dir in string.gmatch(directory_path, "([^/]+)") do
    if first then
      first = false
    else
      directory_prefix = directory_prefix .. dir:sub(1, 1)
    end
  end

  return table.concat(
    {
      directory_prefix,
      vim.fn.fnamemodify(project_root_path, ":t"),
      current_branch,
    },
    ':'
  )
end

return get_project_branch_name
