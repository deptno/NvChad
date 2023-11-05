local file_exists = require('lab/gx/lib/file_exists')
local map         = require('custom.lib.map')

---주어진 infixes 를 기반으로 infix 가 없는 경우를 포함하여 존재하는 파일 목록을 리턴
---TODO: infix 가 여러개인 경우도 존재함 i.g. android.www
---@param infixes table(string) filepath
---@param path string filepath
---@return table|nil
local get_suffix_siblings = function (infixes, path)
  local dirname = vim.fs.dirname(path)
  local filename = vim.fs.basename(path)
  local parts = vim.split(filename, '%.')

  if #parts <= 1 then
    return vim.notify(string.format('invalid filename %s', filename), vim.log.levels.DEBUG)
  end

  local prefix = parts[1]
  local suffix = parts[#parts]

  if not (suffix == 'ts' or suffix == 'tsx') then
    return vim.notify(string.format('unsupported file ext %s', suffix), vim.log.levels.DEBUG)
  end

  local siblings = {}

  -- index.ts
  if #parts == 2 then
    for _, infix in ipairs(infixes) do
      local sibling = table.concat({ prefix, infix, suffix }, '.')

      if file_exists(string.format('%s/%s', dirname, sibling)) then
        table.insert(siblings, sibling)
      end
    end
  else
    -- index.index.ts
    local infix = parts[#parts - 1]
    local has_infix = false
    for _, sibling_infix in ipairs(infixes) do
      if infix == sibling_infix then
        has_infix = true
      end
    end

    local prefix_table = {}
    local prefix_end_index = has_infix and #parts - 2 or #parts - 3

    for i = 1, prefix_end_index do
      table.insert(prefix_table, parts[i])
    end

    prefix = table.concat(prefix_table, '.')

    -- index.{android,ios}.ts
    if has_infix then
      -- insert index.ts
      local sibling = table.concat({ prefix, suffix }, '.')

      if file_exists(string.format('%s/%s', dirname, sibling)) then
        table.insert(siblings, sibling)
      end

      for _, sibling_infix in ipairs(infixes) do
        if infix ~= sibling_infix then
          sibling = table.concat({ prefix, sibling_infix, suffix }, '.')

          if file_exists(string.format('%s/%s', dirname, sibling)) then
            table.insert(siblings, sibling)
          end
        end
      end
    else
      -- index.not-infix.ts
      for _, sibling_infix in ipairs(infixes) do
        -- index.not-infix.{www,ios}.ts
        local sibling = table.concat({ prefix, sibling_infix, suffix }, '.')

        if file_exists(string.format('%s/%s', dirname, sibling)) then
          table.insert(siblings, sibling)
        end
      end
    end
  end

  if #siblings == 0 then
    return
  end

  local with_dir = function (file)
    return string.format('%s/%s', dirname, file)
  end

  return map(with_dir, siblings)
end

return get_suffix_siblings
