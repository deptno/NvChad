vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("RestFileType", { clear = true }),
  callback = function(ev)
    vim.api.nvim_buf_set_var(ev.buf, "vrc_output_buffer_name", string.sub(ev.file, 1, -6) .. ".json")
  end,
})
