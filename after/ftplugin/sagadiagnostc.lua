vim.api.nvim_create_autocmd({"BufWinEnter", "BufEnter"}, {
  group = vim.api.nvim_create_augroup("SagaDiagnostcFiletype", {}),
  callback = function(ev)
    local handler = function ()
      vim.cmd('quit')
    end
    local opts = {
      buffer = ev.buf
    }

    vim.keymap.set('n', 'q', handler, opts)
  end
})
