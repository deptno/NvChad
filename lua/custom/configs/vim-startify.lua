local map      = require('custom/lib/map')

local get_git_files = function ()
  local untracked = function (v) return { line = '❗' .. v, path = v, } end
  local git_files = function (v) return { line = v, path = v, } end
  local ret = {}

  for _, v in ipairs(map(untracked, vim.fn.systemlist('git ls-files -o --exclude-standard 2>/dev/null'))) do
    table.insert(ret, v)
  end
  for _, v in ipairs(map(git_files, vim.fn.systemlist('git ls-files -m 2>/dev/null'))) do
    table.insert(ret, v)
  end

  return ret
end
-- @legacy https://github.com/deptno/.config/blob/8bb421a122c30b172f3cd8ec9ac0f8894fe46bc5/.config/nvim/lua/user/startify.lua
vim.g.startify_show_help = 1
vim.g.startify_show_help_delay = 1
vim.g.startify_show_help_delay_interval = 0.1
vim.g.startify_change_to_dir = 0
vim.g.change_to_vcs_root = 1
vim.g.startify_custom_header = {}
vim.g.startify_update_oldfiles = 1
vim.g.startify_session_autoload = 0
vim.g.startify_skiplist = { '.*OUTLINE$' }
vim.g.startify_enable_special = 0
vim.g.startify_bookmarks = {
  { z = '~/.zshrc' },
  { g = '~/.gitconfig' },
  { f = '~/.finicky.js' },
  { r = '~/tmp/rest.http' },
  { t = '~/.tmux.conf' },
  '~/.taskrc',
}
vim.g.startify_lists = {
    { type = 'dir', header = { '   📂 Current directory ' .. vim.fn.getcwd() } },
    { type = get_git_files, header = { '   💻 Git files' } },
    { type = 'files', header = { '   🕘 Recent ' } },
    { type = 'bookmarks', header = { '   Bookmarks' } },
}
