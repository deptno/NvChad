vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("MarkdownFiletype", {}),
  callback = function(ev)
    local opts = {
      buffer = true
    }
    local handler = function()
      local peek = require('peek')

      if peek.is_open() then
        peek.close()
      else
        peek.open()
      end
    end

    vim.keymap.set("n", ";v", handler, opts)
  end
})
