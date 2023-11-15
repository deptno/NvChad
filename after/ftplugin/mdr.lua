vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("MdrFiletype", {}),
  callback = function(ev)
    local opts = {
      buffer = true
    }
    local handler = function()
      local rmd = require('lab.rmd')
      local parsed = rmd()
      local lang = parsed[1]
      local command = parsed[2]
      local body = parsed[3]

      if not (lang and command and body) then
        return vim.notify(string.format([[
language: %s
command: %s
body: %s
]], lang, command, body), vim.log.levels.ERROR)
      end

        vim.notify(string.format([[
language: %s
command: %s
body: -
]], lang, command), vim.log.levels.INFO)
        local result = vim.fn.system(command, body)
      vim.notify(result)
    end

    vim.keymap.set("n", "<C-j>", handler, opts)
  end
})

vim.treesitter.language.register('markdown', 'mdr')
