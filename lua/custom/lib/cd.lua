local constant = require('custom/lib/constant')
local get_git_root = require('lab/gx/lib/get_git_root')
local get_git_branch_info = require('lab/gx/lib/get_git_branch_info')
local get_git_remote_info = require('lab/gx/lib/get_git_remote_info')

local function notify(title)
  local git_root = get_git_root()
  local git_current_branch = get_git_branch_info()
  local git_remote_info = get_git_remote_info() or { username = '', repository = '' }

  vim.notify(
    string.format([[
repository: %s/%s
branch: %s
git: %s
cwd: %s
]],
      git_remote_info.username,
      git_remote_info.repository,
      git_current_branch,
      vim.fn.fnamemodify(git_root, ':~'),
      vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
    ),
    vim.log.levels.INFO,
    { title = title }
  )
end
local function cd(path)
  local current_session = vim.fs.basename(vim.fn.resolve(constant.PREVIOUS_SESSION_LINK_PATH))

  if path then
    vim.api.nvim_set_current_dir(path)
    notify(string.format('(%s) cd', tostring(current_session)))
  else
    notify(string.format('(%s) cwd', tostring(current_session)))
  end
end

return cd
