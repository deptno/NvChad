vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("SagaCodeActionFiletype", {}),
  callback = function(ev)
    local handler = function ()
      vim.cmd('quit')
    end
    local opts = {
      buffer = true
    }

    vim.keymap.set('n', 'q', handler, opts)
    vim.keymap.set('n', '<esc>', handler, opts)
  end
})
