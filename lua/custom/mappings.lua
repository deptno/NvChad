local M = {}
local cd = require('custom/lib/cd')
local create_toggle_to_fit_width = require('custom/lib/create_toggle_to_fit_width')
local get_visual_selection_text = require('custom/lib/get_visual_selection_text')
local tmux = require('custom/lib/create_tmux_split_window')
local repl = require('custom/lib/repl')
local get_git_root = require('custom/lib/get_git_root')
local select_react_native_siblings = require('custom/lib/select_react_native_siblings')

-- In order to disable a default keymap, use
M.disabled = {
  n = {
    -- chad
    ["<leader>b"] = "",
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
    -- lspconfig
    ["gD"] = "",
    ["gd"] = "",
    ["K"] = "",
    ["gi"] = "",
    -- ["<leader>ls"] = "",
    -- ["<leader>D"] = "",
    ["<leader>ra"] = "",
    ["<leader>ca"] = "",
    ["gr"] = "",
    -- ["<leader>f"] = "",
    ["[d"] = "",
    ["]d"] = "",
    -- ["<leader>q"] = "",
    -- ["<leader>wa"] = "",
    -- ["<leader>wr"] = "",
    -- ["<leader>wl"] = "",
    -- term
    ["<leader>h"] = "",
    ["<leader>v"] = "",
  },
  v = {
    ["<leader>ca"] = "",
  },
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
        vim.cmd('tabe %')
      end,
      "Create tabpage",
    },
    ["-t"] = {
      function()
        local tabs = #vim.api.nvim_list_tabpages()
        if tabs == 1 then
          return
        end

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
    ["cd?"] = {
      cd,
      "Show current working directory"
    },
    ["<C-w>."] = {
      create_toggle_to_fit_width(),
      "Sync window width with buffer"
    },
    ["<F10>"] = {
      function()
        tmux.create_tmux_new_window({ wd = vim.fn.expand('%:p:h') })
      end,
      "Create tmux new window with current buffer path"
    },
    ["<F10><F10>"] = {
      function()
        tmux.create_tmux_new_window()
      end,
      "Create tmux new window"
    },
    ["<F11>"] = {
      function()
        tmux.create_tmux_split_window_vertical({ wd = vim.fn.expand('%:p:h') })
      end,
      "Create tmux horizontal panel with current buffer path"
    },
    ["<F11><F11>"] = {
      function()
        tmux.create_tmux_split_window_vertical()
      end,
      "Create tmux horizontal panel"
    },
    ["<F12>"] = {
      function()
        tmux.create_tmux_split_window_horizontal({ wd = vim.fn.expand('%:p:h') })
      end,
      "create tmux vertical panel with current buffer path"
    },
    ["<F12><F12>"] = {
      function()
        tmux.create_tmux_split_window_horizontal()
      end,
      "create tmux vertical panel"
    },
    ["lz"] = {
      function()
        -- FIXME: get_git_root custom/lib 으로 이동
        local git_root = get_git_root(vim.fn.expand('%:p:h'))
        local work_tree_option = git_root and '-w ' .. git_root or ''
        vim.notify(work_tree_option)
        local command = string.format([[
tmux display-popup \
-d "#{pane_current_path}" \
-w 94%% \
-h 100%% \
-x 100%% \
-EE "lazygit -ucf ~/.config/lazygit/neovim/config.yml %s"]], work_tree_option)
        vim.fn.system(command)
      end,
      "Open lazygit"
    },
    -- base46
    ["<leader>tt"] = {
      function ()
        require('base46').toggle_theme()
      end,
      "Toggle theme",
    },
    ["<leader>rs"] = {
      function ()
        require('custom.snippet')()
      end,
      "run snippet",
    },
    ["q"] = {
      function ()
        local file_type = vim.bo.filetype
        local ft_list = {
          'help',
          'qf',
          'rest',
          'saga_codeaction',
          'sagarename',
        }

        for _, ft in ipairs(ft_list) do
          if file_type == ft then
            vim.cmd('bdelete')
          end
        end
      end,
      "close by q",
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

M.telescope = {
  plugin = true,

  n = {
    ["<leader>ds"] = {
      function ()
        require('telescope.builtin').lsp_dynamic_workspace_symbols()
      end,
      "LSP lsp_dynamic_workspace_symbols"
    },
    ["<leader>gs"] = {
      function ()
        require('telescope.builtin').grep_string({ shorten_path = true, word_match = "-w", only_sort_text = true, search = '' })
      end,
      "Grep string"
    },
    ["<leader>fk"] = {
      function ()
        require('telescope.builtin').keymaps()
      end,
      "telescope: keymaps"
    },
  }
}
M.nvimtree = {
  n = {
    ["sf"] = {
      function ()
        local tree = require("nvim-tree.api").tree
        if tree.is_tree_buf() then
          return
        end

        local visible = tree.is_visible()
        if visible then
          return tree.focus()
        end

        tree.open()
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
      "Undo stage stage hunk",
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
    ["=b"] = {
      function()
        vim.cmd("enew")
      end,
      "New buffer"
    },
    ["-b"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      "Close buffer",
    },
    ["\\b"] = {
      function()
        require("nvchad.tabufline").closeOtherBufs()
      end,
      "Close other buffers",
    },
  },
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

          repl.evaluate(code)
        end
      end,
      "Evaluate code chunk(visual selection)"
    },
    ["<C-r>"] = {
      function()
        local code_lines = get_visual_selection_text()

        if code_lines then
          local code = table.concat(code_lines, '\n')

          repl.run(code)
        end
      end,
      "Run code chunk(visual selection)"
    }
  }
}
M["nvim-ufo"] = {
  n = {
    ["zR"] = {
      function ()
        return require('ufo').openAllFolds()
      end,
      "Open all folds: ufo",
    },
    ["zM"] = {
      function ()
        return require('ufo').closeAllFolds()
      end,
      "Close all folds: ufo",
    },
    ["zr"] = {
      function ()
        return require('ufo').openFoldsExceptKinds()
      end,
      "Open folds except kinds: ufo",
    },
    ["zm"] = {
      function ()
        require('ufo').closeFoldsWith()
      end,
      "Close folds with: ufo",
    },
  },
}
M.persisted = {
  n = {
    ["<F2>"] = {
      function ()
        if not package.loaded['persisted'] then
          return vim.notify('plugin:persisted is not loaded', vim.log.levels.WARN)
        end

        return vim.cmd([[
        :SessionSave
        :Telescope persisted]])
      end,
      "SessionSave + Select session :persisted"
    },
  }
}
local createFxSaga = function (cmd)
  return {
    function()
      if not package.loaded['lspsaga'] then
        return vim.notify('plugin:lspsaga is not loaded', vim.log.levels.WARN)
      end

      return vim.cmd(cmd)
    end,
    cmd,
  }
end
M.lspsaga = {
  n = {
    ["<leader>db"] = createFxSaga('Lspsaga show_buf_diagnostics ++normal'),
    ["<leader>dw"] = createFxSaga('Lspsaga show_workspace_diagnostics ++normal'),
    ["[e"] = createFxSaga('Lspsaga diagnostic_jump_prev'),
    ["]e"] = createFxSaga('Lspsaga diagnostic_jump_next'),
    ["<leader>ra"] = createFxSaga('Lspsaga rename ++project'),
    ["<leader>ca"] = createFxSaga('Lspsaga code_action'),
    -- ["gi"] = createFxSaga('Lspsaga incoming_calls'),
    ["gP"] = createFxSaga('Lspsaga peek_type_definition'),
    ["gp"] = createFxSaga('Lspsaga goto_type_definition'),
    ["gD"] = createFxSaga('Lspsaga peek_definition'),
    ["gd"] = createFxSaga('Lspsaga goto_definition'),
    -- ["gr"] = createFxSaga('Lspsaga finder def+ref+imp+tyd'),
    ["<leader>1"] = createFxSaga('Lspsaga outline'),
    ["K"] = createFxSaga('Lspsaga hover_doc'),
  },
  v = {
    ["<leader>ca"] = createFxSaga('Lspsaga code_action'),
  }
}
M.blame = {
  n = {
    [",b"] = {
      function ()
      if not package.loaded['blame'] then
        return vim.notify('plugin:blame is not loaded', vim.log.levels.WARN)
      end

      vim.cmd('ToggleBlame virtual')
      end
    }
  }
}
M.conform = {
  n = {
    ["<leader>fm"] = {
      function()
        if not package.loaded["conform"] then
          return vim.notify("plugin:conform is not loaded", vim.log.levels.WARN)
        end
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      "format",
    },
  },
}
M.hover = {
  n = {
    ["K"] = {
      function ()
        if not package.loaded['hover'] then
          return vim.notify('plugin:hover is not loaded', vim.log.levels.WARN)
        end
        require("hover").hover()
      end,
      'hover.nvim'
    },
    ["gK"] = {
      function ()
        if not package.loaded['hover'] then
          return vim.notify('plugin:hover is not loaded', vim.log.levels.WARN)
        end
        require("hover").hover_select()
      end,
      'hover.nvim select'
    }
  }
}
M.dap = {
  n = {
    ["<leader>br"] = {
      function ()
        require'dap'.run_to_cursor()
      end,
      "dap: Run to Cursor"
    },
    ["<leader>bC"] = {
      function ()
        require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')
      end,
      "dap: Conditional Breakpoint"
    },
    ["<leader>bb"] = {
      function ()
        require'dap'.step_back()
      end,
      "dap: Step Back"
    },
    ["<leader>bc"] = {
      function ()
        require'dap'.continue()
      end,
      "dap: Continue"
    },
    ["<leader>bd"] = {
      function ()
        require'dap'.disconnect()
      end,
      "dap: Disconnect"
    },
    ["<leader>bg"] = {
      function ()
        require'dap'.session()
      end,
      "dap: Get Session"
    },
    ["<leader>bh"] = {
      function ()
        require'dap.ui.widgets'.hover()
      end,
      "dap: Hover Variables"
    },
    ["<leader>bS"] = {
      function ()
        require'dap.ui.widgets'.scopes()
      end,
      "dap: Scopes"
    },
    ["<leader>bi"] = {
      function ()
        require'dap'.step_into()
      end,
      "dap: Step Into"
    },
    ["<leader>bo"] = {
      function ()
        require'dap'.step_over()
      end,
      "dap: Step Over"
    },
    ["<leader>bp"] = {
      function ()
        require'dap'.pause.toggle()
      end,
      "dap: Pause"
    },
    ["<leader>bq"] = {
      function ()
        require'dap'.close()
      end,
      "dap: Quit"
    },
    ["<leader>bR"] = {
      function ()
        require'dap'.repl.toggle()
      end,
      "dap: Toggle Repl"
    },
    ["<leader>bs"] = {
      function ()
        require'dap'.continue()
      end,
      "dap: Start"
    },
    ["<leader>bt"] = {
      function ()
        require'dap'.toggle_breakpoint()
      end,
      "dap: Toggle Breakpoint"
    },
    ["<leader>bx"] = {
      function ()
        require'dap'.terminate()
      end,
      "dap: Terminate"
    },
    ["<leader>bu"] = {
      function ()
        require'dap'.step_out()
      end,
      "dap: Step Out"
    },
    ["<leader>bl"] = {
      function ()
        vim.cmd('DapShowLog')
      end,
      "dap: Step Out"
    },
  }
}
M.dapui = {
  n = {
    ["<leader>bE"] = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
    ["<leader>b;"] = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
    ["<leader>be"] = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
  },
  v = {
    -- TODO:  범위 코드 evaluation
  }
}
M.harpoon = {
  n = {
    ["<leader>hh"] = {
      function ()
        require('harpoon.ui').toggle_quick_menu()
      end,
      "harpoon: toggle quick menu"
    },
    ["]h"] = {
      function ()
        require('harpoon.ui').nav_next()
      end,
      "harpoon: nav next"
    },
    ["[h"] = {
      function ()
        require('harpoon.ui').nav_prev()
      end,
      "harpoon: nav prev"
    },
    ["<leader>ha"] = {
      function ()
        require('harpoon.mark').add_file()
        vim.notify(string.format('mark'))
      end,
      "harpoon: add mark"
    },
    ["<leader>hd"] = {
      function ()
        require('harpoon.mark').rm_file()
        vim.notify(string.format('unmark'))
      end,
      "harpoon: remove mark"
    },
    ["<leader>hf"] = {
      function ()
        vim.cmd('Telescope harpoon marks')
      end,
      "harpoon: toggle quick menu: cmd"
    },
      }
}
M.trouble = {
  n = {
      ["<leader>xx"] = { function() require("trouble").toggle() end, 'trouble: toggle' },
      ["<leader>xw"] = { function() require("trouble").toggle("workspace_diagnostics") end, 'trouble: workspace_diagnostics' },
      ["<leader>xd"] = { function() require("trouble").toggle("document_diagnostics") end, 'trouble: document_diagnostics' },
      ["<leader>xq"] = { function() require("trouble").toggle("quickfix") end, 'trouble: quickfix' },
      ["<leader>xl"] = { function() require("trouble").toggle("loclist") end, 'trouble: loclist' },
      ["<leader>xr"] = { function() require("trouble").toggle("lsp_references") end, 'trouble: lsp_references' },
      ["gr"] = { function() require("trouble").toggle("lsp_references") end, 'trouble: lsp_references' },
      ["<leader>xi"] = { function() require("trouble").toggle("lsp_implementations") end, 'trouble: lsp_implementations' },
      ["gi"] = { function() require("trouble").toggle("lsp_implementations") end, 'trouble: lsp_implementations' },
      ["<leader>xt"] = { function() require("trouble").toggle("lsp_type_definitions") end, 'trouble: lsp_type_definitions' },
  },
}
M.wip = {
  n = {
    ["<leader>;"] = {
      function ()
        select_react_native_siblings()
      end,
      'wip: select react native siblings'
    }
  }
}

return M
