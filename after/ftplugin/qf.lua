vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("QfFiletype", {}),
  callback = function(ev)
    local opts = {}

    vim.api.nvim_buf_set_keymap(ev.buf, "n", "q", ":quit<CR>", opts)
  end
})
