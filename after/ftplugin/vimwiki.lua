-- 이벤트 순서를 아직 정확히 인지하지 못해 syntax highlight 를 markdown 으로 맞추기 위한 작업
local convert_to_markdown = vim.schedule_wrap(
  function (buf_no)
    if vim.bo.filetype == "vimwiki" then
      vim.api.nvim_buf_set_option(buf_no, "filetype", "markdown")
    end
  end
)

vim.api.nvim_create_autocmd( "BufEnter", {
  pattern = "*.md",
  group = vim.api.nvim_create_augroup("VimwikiFiletype", { clear = true }),
  callback = function(ev)
    local opts = {}

    vim.api.nvim_buf_set_keymap(ev.buf, "n", "L", "<Plug>VimwikiDiaryNextDay", opts)
    vim.api.nvim_buf_set_keymap(ev.buf, "n", "H", "<Plug>VimwikiDiaryPrevDay", opts)
    vim.api.nvim_buf_set_keymap(ev.buf, "n", "<S-x>", "<Plug>VimwikiToggleListItemj", opts)
    vim.api.nvim_buf_set_keymap(ev.buf, "n", "tt", ":VimwikiTable<CR>", opts)
    vim.api.nvim_buf_set_keymap(ev.buf, "n", ";w", ":execute 'VWS /' . expand('<cword>') . '/' <Bar> :lopen<CR>", opts)
    vim.api.nvim_buf_set_keymap(ev.buf, "n", ";b", ":execute 'VWB' <Bar> :lopen<CR>", opts)

    convert_to_markdown(ev.buf)
  end
})
