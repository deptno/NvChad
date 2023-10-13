local get_project_branch_name = require('custom/lib/get_project_branch_name')
local constant = require('custom/lib/constant')

local get_previous_session = function ()
  local __LAST__ = '__LAST__'
  local fn = vim.fn
  local last_session_path = fn.stdpath('data') .. '/session/' .. __LAST__
  local current_session = fn.resolve(last_session_path)

  if vim.fs.basename(current_session )== last_session_path then
    return print("There is no last_session_path")
  end

  return current_session
end
local create_previous_session_link = function(previous_session)
  if previous_session then
    local source = '../' .. vim.fs.basename(previous_session)

    vim.fn.system('ln -fs ' .. source .. ' ' .. constant.PREVIOUS_SESSION_LINK_PATH)

    return true
  end

  return false
end
local switch_previous_session = function ()
  local current_session = vim.fn.resolve(constant.PREVIOUS_SESSION_LINK_PATH)

  if vim.fn.filereadable(current_session) then
    vim.cmd('SLoad ' .. vim.fs.basename(current_session))
  end
end
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
vim.g.startify_session_before_save_handler = function ()
  local close_symbols_outline = function ()
    local success, so = pcall(require('symbols-outline'))

    if success then
      if so.view:is_open() then
        so.close_outline()
        print("close outline")
      end
    end
  end
  ---neogit 관련 닫기를 처리한다
  ---닫아도 안닫아도 버그가 있으나 닫는게 사용하기 좀 더 편함
  ---안닫을시: 세션으로 복귀할때 해당 파일관련된 수저이 저장되지 않았다는 등의 메시지가 나옴, neogit 어느 순간 안됨
  ---닫을시: 메시지 안뜨고 갑자기 neogit 안됨
  local close_special_buffer = function ()
    local handled = false
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
      local is_special = string.find(filetype, 'Neogit') == 1

      if is_special then
        vim.api.nvim_buf_delete(bufnr, { force = true })
        handled = true
      end
    end
    if handled then
      -- 빈 버퍼가 보이는 것 방지
      vim.cmd('bnext')
    end
  end

  require("nvim-tree.api").tree.close()
  close_symbols_outline()
  close_special_buffer()
end
-- @legacy https://github.com/deptno/.config/blob/8bb421a122c30b172f3cd8ec9ac0f8894fe46bc5/.config/nvim/lua/user/startify.lua
vim.g.startify_show_help = 1
vim.g.startify_show_help_delay = 1
vim.g.startify_show_help_delay_interval = 0.1
vim.g.startify_change_to_dir = 0
vim.g.change_to_vcs_root = 1
vim.g.startify_custom_header = {}
vim.g.startify_update_oldfiles = 1
vim.g.startify_session_persistence = 1
vim.g.startify_session_autoload = 1
vim.g.startify_enable_special = 0
vim.g.startify_session_before_save = {
  'lua vim.g.startify_session_before_save_handler()',
}
vim.g.startify_bookmarks = {
  { bz = '~/.zshrc' },
  { bg = '~/.gitconfig' },
  { bf = '~/.finicky.js' },
  { br = '~/tmp/rest.http' },
  { bt = '~/.tmux.conf' },
  '~/.taskrc',
}
-- session list wrapper 를 만들기 귀찮아서 처리
vim.g.startify_custom_indices = {
  'c.',
  'cn',
  'dn',
  'p0',
  'pd',
  'pt',
  'ph',
  'ps',
  'pz',
  'wp',
  'ww',
}
vim.g.switch_previous_session = switch_previous_session
vim.g.startify_commands = {
  { l = { "previous session", "= vim.g.switch_previous_session()" }, },
}
vim.g.startify_lists = {
    { type = 'commands', header = { '   Commands' } },
    { type = 'sessions', header = { '   Sessions' } },
    { type = get_git_files, header = { '   💻 Git files' } },
    { type = 'files', header = { '   🕘 Recent ' } },
    { type = 'dir', header = { '   📂 Current directory ' .. vim.fn.getcwd() } },
    { type = 'bookmarks', header = { '   Bookmarks' } },
}

vim.api.nvim_create_autocmd("SessionLoadPost", {
  group = vim.api.nvim_create_augroup("StartifyAutoSaveSession", { clear = true }),
  callback = function()
    local previous_session = get_previous_session()

    if previous_session then
      local is_created = create_previous_session_link(previous_session)

      if is_created then
        vim.schedule(function ()
          local current_session = get_previous_session()

          if previous_session ~= current_session then
            vim.notify(
              vim.fs.basename(current_session),
              vim.log.levels.INFO,
              { title = 'Session changed' }
            )
          end
        end)
      end
    end
  end,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = vim.api.nvim_create_augroup("StartifyVimLeavePreAutoSaveSession", { clear = true }),
  callback = create_previous_session_link,
})
vim.api.nvim_create_user_command(
  'GetProjectBranchName',
  get_project_branch_name,
  {}
)
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
]]
