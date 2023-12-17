vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("SetKnownRubyFileType", { clear = true }),
  pattern = { "Podfile" },
  callback = function()
    -- @see https://github.com/neovim/neovim/blob/670c7609c85547ef041af8cf17139a396d6af050/runtime/filetype.lua#L31
    vim.api.nvim_cmd({ cmd = "setf", args = { "ruby" } }, {})
  end,
})
