local function handler()

end
local function find_normal_handler(mode, line)
  if mode == 'n' then

  end
end

local function search_for_url ()
  local line = vim.api.nvim_get_current_line()
  local mode = vim.api.nvim_get_mode().mode

  if mode == 'n' then
    local match = string.match(line, "B2C%-%d+") -- B2C-34000
    if match then
      print("match" .. match)
      local Job = require("plenary.job")
      local command = "open"

      local result, return_val = Job:new({
        command,
        args = {
          "https://zigbang.atlassian.net/browse/" .. match
        },
      }):sync()

      print(result, return_val)

    end
  end
  print("hello search_for_url", line, mode)
end

local function init()
  vim.g.netrw_nogx = 1 -- disable netrw gx

  local opts = { noremap = true, silent = true }

  vim.keymap.set("n", "gx", search_for_url, opts)
  vim.keymap.set("v", "gx", search_for_url, opts)
end

vim.api.nvim_create_user_command(
  'Gx',
  search_for_url,
  {}
)

init()

print("wip lab/gx")
