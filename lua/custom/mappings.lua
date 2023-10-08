local M = {}
local cd = require('custom/lib/cd')
local create_toggle_to_fit_width = require('custom/lib/create_toggle_to_fit_width')
local get_visual_selection_text = require('custom/lib/get_visual_selection_text')
local tmux = require('custom/lib/create_tmux_split_window')

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
    ["]t"] = {
      function()
        vim.cmd('tabnext')
      end,
      "Goto next tabpage",
    },
    ["[t"] = {
      function()
        vim.cmd('tabprevious')
      end,
      "Goto prev tabpage",
    },
    ["=t"] = {
      function()
        vim.cmd('tabnew')
        require("telescope.builtin").find_files({
          hidden=true,
          layout_config={ prompt_position = "bottom" }
        })
      end,
      "Create tabpage",
    },
    ["-t"] = {
      function()
        vim.cmd('tabclose')
      end,
      "Close tabpage",
    },
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
    },
    ["<F11>"] = {
      function()
        tmux.create_tmux_split_window_vertical()
      end,
      "Create tmux horizontal panel"
    },
    ["<F12>"] = {
      function()
        tmux.create_tmux_split_window_horizontal()
      end,
      "create tmux vertical panel"
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
M["nvim-notify"] = {
  v = {
    ["<C-r>="] = {
      function()
        local code_lines = get_visual_selection_text()

        if code_lines then
          if not string.match(code_lines[#code_lines], "^%s*return ") then
            code_lines[#code_lines] = 'return ' .. code_lines[#code_lines]
          end

          local code = table.concat(code_lines, '\n')

          vim.notify(code, vim.log.levels.INFO, {
            title = "Result",
            on_open = function (win)
              local buf = vim.api.nvim_win_get_buf(win)
              local filetype = vim.bo.filetype

              vim.api.nvim_buf_set_option(buf, "filetype", filetype)

              vim.schedule(function ()
                local chunk = load('local runner = function()\n' .. code .. '\nend\nreturn runner()')
                local success, result = pcall(chunk)

                if success then
                  if type(result) == 'table' then
                    result = vim.inspect(result)
                  end
                  vim.notify(tostring(result), vim.log.levels.INFO, { title = "Result" })
                else
                  vim.notify("Fail", vim.log.levels.ERROR, { title = "Result" })
                end
              end)
            end
          })
        end
      end,
      "Evaluate code chunk(visual selection)"
    },
    ["<C-r>"] = {
      function()
        local code_lines = get_visual_selection_text()

        if code_lines then
          local code = table.concat(code_lines, '\n')

          vim.notify(code, vim.log.levels.INFO, {
            title = "Run code",
            on_open = function (win)
              local buf = vim.api.nvim_win_get_buf(win)
              local filetype = vim.bo.filetype

              vim.api.nvim_buf_set_option(buf, "filetype", filetype)

              vim.schedule(function ()
                local chunk = load('local runner = function()\n' .. code .. '\nend\nreturn runner()')
                local success, result = pcall(chunk)

                if success then
                  vim.notify("Success", vim.log.levels.INFO)
                else
                  vim.notify("Fail", vim.log.levels.ERROR)
                end
              end)
            end
          })
        end
      end,
      "Run code chunk(visual selection)"
    }
  }
}
return M
