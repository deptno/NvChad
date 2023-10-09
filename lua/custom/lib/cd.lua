local function cd(path)
  vim.api.nvim_set_current_dir(path)
  vim.notify(vim.fn.fnamemodify(vim.fn.getcwd(), ':~'), vim.log.levels.INFO, {
    title = "Change working directory"
  })
end

return cd
