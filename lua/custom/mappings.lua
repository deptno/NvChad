local M = {}

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
    ["]b"] = {
      function()
        vim.cmd("bnext")
      end,
      "Next buffer"
    },
    ["[b"] = {
      function()
        vim.cmd("bprevious")
      end,
      "Previous buffer"
    },
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
    ["cd."] = {
      function()
        require("nvim-tree.api").tree.change_root(vim.fn.expand("%:p:h"))
      end,
      "Change working directory to current directory"
    },
    ["cd.."] = {
      function()
        require("nvim-tree.api").tree.change_root(vim.fn.expand("%:p:h:h"))
      end,
      "Change working directory to parent directory"
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
  }
}

M.tabufline = {
  n = {
    ["<]b>"] = {
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

return M
