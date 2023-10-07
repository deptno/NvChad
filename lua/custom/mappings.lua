local M = {}
local function cd(path)
  print("cd " .. path)
  vim.api.nvim_set_current_dir(path)
end
local function create_toggle_to_fit_width()
  local buf_cache = {}

  return function()
    local bufnr = vim.fn.bufnr()
    local lines = vim.fn.getbufline(bufnr, 1, '$')
    local width = 30 -- minimum width

    for _, v in ipairs(lines) do
      local line_width = vim.fn.strdisplaywidth(v)
      if line_width > width then
        width = line_width
      end
    end

    local current_width = vim.api.nvim_win_get_width(0)

      print(vim.inspect(buf_cache))
    if
      current_width == width
      and buf_cache[bufnr]
      and buf_cache[bufnr] ~= current_width
    then
      vim.api.nvim_win_set_width(0, buf_cache[bufnr])
    else
      buf_cache[bufnr] = current_width
      vim.api.nvim_win_set_width(0, width)
    end
  end
end

-- In order to disable a default keymap, use
M.disabled = {
  n = {
    -- nvimtree
    ["<C-n>"] = "",
    ["<leader>e"] = "",
    -- gitsigns
    ["<leader>rh"] = "",
    ["<leader>ph"] = "",
    ["<leader>gb"] = "",
    ["<leader>td"] = "",
    -- tabufline
    ["<leader>x"] = "",
    ["<tab>"] = "",
    ["<S-tab>"] = "",
  }
}

-- Your custom mappings
M.general = {
  n = {
    ["sw"] = {
      function()
        vim.wo.wrap = not vim.wo.wrap
      end,
      "Toggle softwrap"
    },
    ["cd."] = {
      function()
        cd(vim.fn.expand("%:p:h"))
      end,
      "Change working directory to current directory"
    },
    ["cd.."] = {
      function()
        cd("..")
      end,
      "Change working directory to parent directory"
    },
    ["cdp"] = {
      function()
        cd(vim.fn.system('git rev-parse --show-toplevel'):gsub('\n', ''))
      end,
      "Change working directory to current git root"
    },
    ["cdg"] = {
      function()
        cd("~/workspace/src/github.com")
      end,
      "Change working directory to parent directory"
    },
    ["<C-w>."] = {
      create_toggle_to_fit_width(),
      "Sync window width with buffer"
    }
  },
  v = {
    ["H"] = {
      function()
        vim.cmd("vert help " .. vim.fn.expand("<cword>"))
      end,
      "Vertical help <cword> in visual mode"
    },
  }
}
M.nvimtree = {
  n = {
    ["sf"] = {
      function ()
        require("nvim-tree.api").tree.toggle()
      end,
      "Toggle nvimtree"
    },
  },
}
M.gitsigns = {
  n = {
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
        local gs = require("gitsigns")
        gs.next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },
    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          local gs = require("gitsigns")
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },
    [",r"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },
    [",."] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },
    [",,"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },
    [",t"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
    [",s"] = {
      function()
        require("gitsigns").stage_hunk()
      end,
      "Stage stage hunk",
    },
    [",S"] = {
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      "Stage stage hunk",
    },
    [",q"] = {
      function()
        require("gitsigns").setqflist()
      end,
      "Set qf list",
    },
  },
  v = {
    [",r"] = {
      function()
        require("gitsigns").reset_hunk({vim.fn.line('.'), vim.fn.line('v')})
      end,
      "Reset stage hunk",
    },
    [",s"] = {
      function()
        require("gitsigns").stage_hunk({vim.fn.line('.'), vim.fn.line('v')})
      end,
      "Stage stage hunk",
    },
  }
}
M.tabufline = {
  n = {
    ["]b"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },
    ["[b"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },
    ["-b"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      "Close buffer",
    },
  },
}
M["symbols-outline"] = {
  n = {
    ["<leader>1"] = {
      function()
        require("symbols-outline").toggle_outline()
      end,
      "Toggle symbol-outline"
    }
  }
}
M.startify = {
  n = {
    ["<leader>s"] = {
      function ()
        vim.cmd("Startify")
      end
    }
  }
}

return M
