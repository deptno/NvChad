local function gx()
  local mode = vim.api.nvim_get_mode().mode
  local line = vim.api.nvim_get_current_line()

  if mode == 'n' then
    local handlers = require('lab/gx/handlers_n')

    for _, handler in ipairs(handlers) do
      if handler(line) then
        return
      end
    end
  elseif mode == 'v' then
    local handlers = require('lab/gx/handlers_v')

    for _, handler in ipairs(handlers) do
      if handler(line) then
        return
      end
    end
  end

  -- call default handler
  vim.cmd("call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))")
end

local function init()
  -- disable default handler
  vim.g.netrw_nogx = 1

  local opts = { noremap = true, silent = true }

  vim.keymap.set("n", "gx", gx, opts)
  vim.keymap.set("v", "gx", gx, opts)
end

vim.api.nvim_create_user_command('Gx', gx, {})

init()
