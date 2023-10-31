vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
  pattern = "*.md",
  group = vim.api.nvim_create_augroup("VimwikiFiletype", {}),
  callback = function(ev)
    local opts = {}

    vim.api.nvim_buf_set_keymap(ev.buf, "n", "L", "<Plug>VimwikiDiaryNextDay", opts)
    vim.api.nvim_buf_set_keymap(ev.buf, "n", "H", "<Plug>VimwikiDiaryPrevDay", opts)
    vim.api.nvim_buf_set_keymap(ev.buf, "n", "<S-x>", "<Plug>VimwikiToggleListItemj", opts)
    vim.api.nvim_buf_set_keymap(ev.buf, "n", "tt", ":VimwikiTable<CR>", opts)
    -- use gx grep instead
    -- vim.api.nvim_buf_set_keymap(ev.buf, "n", ";w", ":execute 'VWS /' . expand('<cword>') . '/' <Bar> :lopen<CR>", opts) 
    vim.api.nvim_buf_set_keymap(ev.buf, "n", ";b", ":execute 'VWB' <Bar> :lopen<CR>", opts)
  end
})
