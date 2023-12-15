local ftq = require "custom.lib.ftq"

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("SagaDiagnostcFiletype", {}),
  callback = ftq,
})
