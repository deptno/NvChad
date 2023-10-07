local function cd(path)
  print("cd " .. path)
  vim.api.nvim_set_current_dir(path)
end

return cd
