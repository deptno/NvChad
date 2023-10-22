return {
  theme_toggle = { "onenord_light", "kanagawa" },
  theme = "kanagawa",
  statusline = {
    theme = "vscode_colored",
    separator_style = "default",
    overriden_modules = function (modules)
      local session = vim.g.persisted_loaded_session or "-"
      local normalized = vim.fs.basename(session:gsub('%%', '/'))
      local branch_index = normalized:find('@@')
      local name = branch_index and normalized:sub(0, branch_index - 1) or normalized

      table.insert(modules, 3, ' 📂' .. name .. ' ')
    end
  },

}
