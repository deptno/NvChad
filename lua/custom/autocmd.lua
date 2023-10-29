vim.api.nvim_create_autocmd("SessionLoadPost", {
  group = vim.api.nvim_create_augroup("AfterSessionLoadPost", { clear = true }),
  callback = function()
    vim.cmd(':clearjumps')
  end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = { "*.rest", "*.http" },
  group = vim.api.nvim_create_augroup("SetRestFileType", { clear = true }),
  callback = function(ev)
    vim.api.nvim_buf_set_option(ev.buf, "filetype", "rest")
    vim.api.nvim_buf_set_var(ev.buf, "vrc_output_buffer_name", string.sub(ev.file, 1, -6) .. ".json")
  end,
})
