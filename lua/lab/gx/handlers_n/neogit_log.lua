local is_git_hash = require('lab/gx/lib/is_git_hash')
local handler = function(line, matched)
  local success, neogit = pcall(require, 'neogit')

  if not success then
    return vim.notify(neogit, vim.log.levels.ERROR)
  end

  neogit.open({ 'log' })
  if string.gmatch(tostring(vim.cmd('set ft?')), 'NeogitPopup') then
    vim.api.nvim_feedkeys('l', 't', false)
    vim.schedule(function ()
      vim.api.nvim_feedkeys(string.format('/%s\n', matched:sub(1, 7)), 't', true)
    end)
  end
end
local match = is_git_hash
local name = 'neogit log'

return {
  handler = handler,
  match = match,
  name = name,
}
