local mdr = function ()
  local parser = vim.treesitter.get_parser(nil, 'markdown')
  local tree = parser:parse()
  local root = tree[1]:root()
  local query = vim.treesitter.query.parse('markdown', [[
(
  (section
  . (fenced_code_block
      (info_string
        (language) @lang (#eq? @lang "sh"))
    (code_fence_content) @command))
  .
  (section) @body)
]])
  local language
  local command
  local body

  for pattern, match, metadata in query:iter_matches(root, 0) do
    for id, node in pairs(match) do
      local name = query.captures[id]

      if name == 'lang' then
        language = vim.treesitter.get_node_text(node, 0)
      elseif name == 'command' then
        command = vim.treesitter.get_node_text(node, 0)
      elseif name == 'body' then
        body = table.concat(vim.api.nvim_buf_get_lines(0, node:range(), -1, {}), '\n')
      end
    end
  end

  return { language, command, body }
end

return mdr
