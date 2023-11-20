local filter = require "custom.lib.filter"
local snippet = function ()
  local snippets = filter(
    function (v)
      return vim.fn.fnamemodify(v, ':t') ~= 'init.lua'
    end,
    vim.split(vim.fn.glob(vim.fn.stdpath('config') .. "/lua/custom/snippet/*"), '\n')
  )

  vim.ui.select(
    snippets,
    {
      prompt = 'select snippet to run',
    },
    function(item)
      local ext = vim.fn.fnamemodify(item, ':e')

      if ext == 'lua' then
        local result  = loadfile(item)()
      else
        vim.notify(string.format('unsupported extension: %s', ext), vim.log.levels.WARN)
      end
    end
  )
end

return snippet

