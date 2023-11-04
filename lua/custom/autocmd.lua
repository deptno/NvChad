vim.api.nvim_create_autocmd("SessionLoadPost", {
  group = vim.api.nvim_create_augroup("AfterSessionLoadPost", { clear = true }),
  callback = function()
    vim.cmd(':clearjumps')
  end,
})
