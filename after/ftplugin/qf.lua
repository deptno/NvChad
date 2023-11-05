vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("QuickFixFiletype", { clear = true }),
  callback = function(ev)
    vim.notify('*warning* autocmd QuickFixFiletype', vim.log.levels.TRACE)
    if vim.bo.filetype ~= 'qf' then
      -- FIXME: qf 파일타입에서 뿐 아니라 qf 가 한번 열리면 그 이후로  모든 버퍼에 대해서 호출됨
      return
    end

    local opts = {
      buffer = true
    }
    local handler = function ()
      vim.cmd('quit')
    end

    vim.keymap.set('n', 'q', handler, opts)
  end
})
