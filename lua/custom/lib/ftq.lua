---
---특정 버퍼에서 `q` 를 통해 buffer 를 닫는 용도로 사용
---after/ftplugin/*.lua 에서 사용
---
local ftq = function ()
  local opts = {
    buffer = true
  }
  local handler = function ()
    vim.cmd('bwipeout')
  end

  vim.keymap.set('n', 'q', handler, opts)
end

return ftq
