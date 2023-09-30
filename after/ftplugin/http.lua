vim.api.nvim_create_autocmd( "BufEnter", {
  group = vim.api.nvim_create_augroup("HttpFiletype", { clear = true }),
  callback = function(ev)
    local opts = {}

    vim.api.nvim_buf_set_keymap(ev.buf, "n", "q", ":bdelete<CR>", opts)
    vim.api.nvim_buf_set_keymap(ev.buf, "n", "<CR>", "<Plug>RestNvim", opts)
    vim.api.nvim_buf_set_keymap(ev.buf, "n", "P", "<Plug>RestNvimPreview", opts)
    vim.api.nvim_buf_set_keymap(ev.buf, "n", "L", "<Plug>RestNvimLast", opts)
  end
})
