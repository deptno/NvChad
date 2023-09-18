vim.api.nvim_create_autocmd( "BufEnter", {
  pattern = "*.md",
  callback = function(ev)
    local opts = {}

    vim.api.nvim_buf_set_option(ev.buf, "filetype", "markdown")

    vim.api.nvim_buf_set_keymap(ev.buf, "n", "L", "<Plug>VimwikiDiaryNextDay", opts)
    vim.api.nvim_buf_set_keymap(ev.buf, "n", "H", "<Plug>VimwikiDiaryPrevDay", opts)
    vim.api.nvim_buf_set_keymap(ev.buf, "n", "<S-x>", "<Plug>VimwikiToggleListItemj", opts)
    vim.api.nvim_buf_set_keymap(ev.buf, "n", "tt", ":VimwikiTable<CR>", opts)
    vim.api.nvim_buf_set_keymap(ev.buf, "n", ";w", ":execute 'VWS /' . expand('<cword>') . '/' <Bar> :lopen<CR>", opts)
    vim.api.nvim_buf_set_keymap(ev.buf, "n", ";b", ":execute 'VWB' <Bar> :lopen<CR>", opts)
    vim.api.nvim_buf_set_keymap(ev.buf, "n", ";i", "<Plug>VimwikiDiaryGenerateLinks", opts)
  end
})
