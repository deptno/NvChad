-- 중복 정의 제거
local map = function (fn, tlb)
  assert(type(fn) == "function", "fn: function")
  assert(type(tlb) == "table", "tlb: table(list)")

  local ret = {}

  for _, v in ipairs(tlb) do
    table.insert(ret, fn(v))
  end

  return ret
end
local function gx()
  local mode = vim.api.nvim_get_mode().mode
  local line = vim.api.nvim_get_current_line()

  if mode == 'n' then
    local handlers = require('lab/gx/handlers_n')
    local matched_handlers = {}

    for _, h in ipairs(handlers) do
      if h.match(line) then
        table.insert(matched_handlers, h)
      end
    end

    if #matched_handlers == 1 then
      matched_handlers[#matched_handlers].handler(line)
    elseif (#matched_handlers > 1) then

      -- B2C-33333
      return vim.ui.select(matched_handlers, {
        prompt = "handlers:",
        format_item = function(h)
          return h.name
        end
      }, function(selected)
          selected.handler(line, selected.match(line))
        end)
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
