local map = function (fn, tlb)
  assert(type(fn) == "function", "fn: function")
  assert(type(tlb) == "table", "tlb: table(list)")

  local ret = {}

  for _, v in ipairs(tlb) do
    table.insert(ret, fn(v))
  end

  return ret
end
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

-- https://github.com/deptno/.config/blob/8bb421a122c30b172f3cd8ec9ac0f8894fe46bc5/.config/nvim/lua/user/startify.lua
vim.g.startify_bookmarks = {
  { bz = '~/.zshrc' },
  { bg = '~/.gitconfig' },
  { bf = '~/.finicky.js' },
  { br = '~/tmp/rest.http' },
  { bt = '~/.tmux.conf' },
  '~/.taskrc',
}
vim.g.startify_show_help = 1
vim.g.startify_show_help_delay = 1
vim.g.startify_show_help_delay_interval = 0.1
vim.g.startify_change_to_dir = 0
vim.g.change_to_vcs_root = 1
vim.g.startify_custom_header = {}
-- sessions wrapper 를 만들기 귀찮아서 처리
vim.g.startify_custom_indices = {
  'cn',
  'dn',
  'p0',
  'pd',
  'pt',
  'ph',
  'pz',
  'wp',
  'ww',
  'll',
}
vim.g.startify_lists = {
    { type = 'sessions', header = { '   Sessions' } },
    { type = get_git_files, header = { '   💻 Git files' } },
    { type = 'files', header = { '   🕘 Recent ' } },
    { type = 'dir', header = { '   📂 Current directory ' .. vim.fn.getcwd() } },
    { type = 'commands', header = { '   Commands' } },
    { type = 'bookmarks', header = { '   Bookmarks' } },
}

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = vim.api.nvim_create_augroup("StartifyAutoSaveSession", { clear = true }),
  callback = function()
    vim.cmd("SSave! _latest")
  end,
})
vim.cmd [[
function! GetUniqueSessionName()
  let path = fnamemodify(getcwd(), ':~:t')
  let path = empty(path) ? 'no-project' : path
  let branch = gitbranch#name()
  let branch = empty(branch) ? '' : '-' . branch
  return substitute(path . branch, '/', '-', 'g')
endfunction

command! StartifySaveBranchSession ':SSave! ' . GetUniqueSessionName()
command! StartifyLoadBranchSession ':SLoad ' . GetUniqueSessionName()

nnoremap <silent> ;s :Startify<CR>
]]
