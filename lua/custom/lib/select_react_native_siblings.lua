local get_suffix_siblings = require('custom/lib/get_suffix_siblings')

local select_react_native_siblings = function ()
  local infixes = {
    'zigbang',
    'daum',
    'native',
    'www',
    'ios',
    'android',
  }
  local siblings = get_suffix_siblings(infixes, vim.fn.expand('%'))

  if siblings then
    if #siblings > 0 then
      local filename = vim.fs.basename(vim.fn.expand('%'))

      vim.ui.select(
        siblings,
        {
          prompt = string.format('Select sibling of %s:', filename),
        },
        function(sibling)
          vim.cmd(string.format('edit %s', vim.fn.basename(sibling)))
        end
      )
    end
  end
end

return select_react_native_siblings
