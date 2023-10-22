vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("QfFiletype", { clear = true }),
  callback = function(ev)
    local opts = {}

    vim.api.nvim_buf_set_keymap(ev.buf, "n", "q", ":quit<CR>", opts)
  end
})
