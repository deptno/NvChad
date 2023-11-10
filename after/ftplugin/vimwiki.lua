vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
  pattern = "*.md",
  group = vim.api.nvim_create_augroup("VimwikiFiletype", {}),
  callback = function(ev)
    local opts = {
      buffer = true
    }
    local handler = function()
      local peek = require('peek')

      if peek.is_open() then
        peek.close()
      else
        peek.open()
      end
    end

    vim.keymap.set("n", "L", "<Plug>VimwikiDiaryNextDay", opts)
    vim.keymap.set("n", "H", "<Plug>VimwikiDiaryPrevDay", opts)
    vim.keymap.set("n", "<S-x>", "<Plug>VimwikiToggleListItemj", opts)
    vim.keymap.set("n", "tt", ":VimwikiTable<CR>", opts)
    vim.keymap.set("n", ";b", ":execute 'VWB' <Bar> :lopen<CR>", opts)
    vim.keymap.set("n", ";v", handler, opts)
  end
})
