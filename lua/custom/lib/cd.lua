local function cd(path)
  vim.api.nvim_set_current_dir(path)
  vim.notify(string.gsub(path, vim.fn.expand('~'), '~'), vim.log.levels.INFO, {
    title = "Change working directory"
  })
end

return cd
