return {
  {
    'folke/neodev.nvim',
    config = function ()
      require('neodev').setup({})
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'folke/neodev.nvim',
    },
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = function()
      local chad = require("plugins.configs.others").blankline
      local custom = require("custom.configs.indent-blankline")
      local merged = vim.tbl_deep_extend("force", chad, custom)

      return merged
    end,
  },
  {
    "lbrayner/vim-rzip",
    lazy = false,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      'nvim-telescope/telescope-ui-select.nvim'
    },
    opts = function()
      local chad = require("plugins.configs.telescope")
      local custom = require("custom.configs.telescope")
      local merged = vim.tbl_deep_extend("force", chad, custom)

      return merged
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("persisted")
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "petertriho/cmp-git",
      "hrsh7th/cmp-emoji",
    },
    opts = function()
      local chad = require("plugins.configs.cmp")
      local custom = require("custom.configs.cmp")
      local merged = vim.tbl_deep_extend("force", chad, custom)

      return merged
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
      require("cmp_git").setup(require("custom.configs.cmp_git"))
    end,
    event = 'VeryLazy',
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      local opt = require("plugins.configs.others").gitsigns
      opt.numhl = true

      return opt
    end,
    event = 'VeryLazy',
  },
  {
    "vimwiki/vimwiki",
    init = function()
      require("custom.configs.vimwiki")
    end,
    ft = { "markdown" },
    keys = {
      { "<leader>ww", mode = "n", desc = "vimwiki index" },
      { "<leader>w<leader>w", mode = "n", desc = "vimwiki diary" },
    }
  },
  {
    "mhinz/vim-startify",
    lazy = false,
    init = function ()
      require("custom.configs.vim-startify")
    end
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    config = function ()
      require("nvim-surround").setup({})
    end,
    event = "VeryLazy",
  },
  {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
    end,
    event = 'VeryLazy',
  },
  {
    "sindrets/diffview.nvim",
    config = function (_, opts)
      require("diffview").setup(require("custom.configs.diffview"), opts)
    end,
    event = 'VeryLazy',
  },
  {
    "diepm/vim-rest-console",
    config = function ()
      vim.g.vrc_curl_opts = { ["-s"] = "" }
    end,
    ft = { "rest" },
  },
  {
    'stevearc/dressing.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      select = {
        enabled = true,
      }
    },
  },
  {
    'rcarriga/nvim-notify',
    init = function ()
      local notify = require('notify')

      notify.setup({
        render = "wrapped-compact",
        stages = "static",
        timeout = 3000,
      })
      vim.notify = notify
    end
  },
  {
    'chentoast/marks.nvim',
    opts = require('custom/configs/marks'),
    event = 'VeryLazy',
  },
  {
    'backdround/tabscope.nvim',
    config = true,
  },
  {
    'olimorris/persisted.nvim',
    opts = {
      autoload = true,
      follow_cwd = false,
      use_git_branche = true,
    },
    config = true,
  },
  {
    'gioele/vim-autoswap',
    lazy = false,
  },
  {
    'nvimdev/lspsaga.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require('lspsaga').setup({
        finder = {
          max_height = 0.8,
          left_width = 0.3,
          right_width = 0.5,
          methods = {
            tyd = 'textDocument/typeDefinition',
          },
        },
        hover = {
          max_width = 0.9,
          max_height = 0.8,
          open_cmd = '!min',
        },
        symbol_in_winbar = {
          folder_level = 4,
        },
        code_action = {
          show_server_name = true,
        },
        outline = {
          detail = false,
        },
      })
    end,
    event = 'LspAttach',
  },
  {
    'f-person/git-blame.nvim',
    event = 'VeryLazy'
  },
  {
    'FabijanZulj/blame.nvim',
    opts = {
      virtual_style = 'float'
    },
    event = 'VeryLazy'
  },
  {
    "stevearc/conform.nvim",
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier", "eslint_d" },
        javascriptreact = { "prettier", "eslint_d" },
        typescript = { "prettier", "eslint_d" },
        typescriptreact = { "prettier", "eslint_d" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    cmd = { "ConformInfo" },
    event = 'LspAttach',
  },
  {
    "lewis6991/hover.nvim",
    config = function()
      require("hover").setup {
        init = function()
          require("hover.providers.lsp")
          require('hover.providers.gh')
          require('hover.providers.gh_user')
          require('hover.providers.jira')
          require('hover.providers.man')
          require('hover.providers.dictionary')
        end,
        preview_opts = {
          border = nil
        },
        preview_window = false,
        title = true
      }
    end,
    event = 'VeryLazy'
  },
  -- {
  --   'mfussenegger/nvim-dap',
  --   dependencies = {
  --     'rcarriga/nvim-dap-ui',
  --     'mxsdev/nvim-dap-vscode-js',
  --     {
  --       'microsoft/vscode-js-debug',
  --       version = '1.x',
  --       build = 'npm i && npm run compile vsDebugServerBundle && mv dist out'
  --     }
  --   },
  --   config = function ()
  --     require('dapui').setup()
  --
  --     local debugger_path = vim.fn.stdpath('data') .. "/lazy/vscode-js-debug"
  --     require('dap-vscode-js').setup({
  --       debugger_path = debugger_path,
  --       adapters = {
  --         'pwa-node',
  --         'pwa-chrome',
  --         'pwa-msedge',
  --         'node-terminal',
  --         'pwa-extensionHost',
  --       },
  --       node_path = "node",
  --       debugger_cmd = { "js-debug-adapter" },
  --       log_file_path = vim.fn.stdpath('cache') .. "/dap_vscode_js.log",
  --       log_file_level = vim.log.levels.ERROR,
  --       log_console_level = vim.log.levels.ERROR,
  --     })
  --
  --     local js_based_languages = { "typescript", "javascript", "typescriptreact" }
  --     for _, language in ipairs(js_based_languages) do
  --       require("dap").configurations[language] = {
  --         {
  --           type = "pwa-node",
  --           request = "launch",
  --           name = "Launch file",
  --           program = "${file}",
  --           cwd = "${workspaceFolder}",
  --         },
  --         {
  --           type = "pwa-node",
  --           request = "attach",
  --           name = "Attach",
  --           processId = require('dap.utils').pick_process,
  --           cwd = "${workspaceFolder}",
  --         },
  --         {
  --           type = "pwa-chrome",
  --           request = "launch",
  --           name = "Start Chrome with 'localhost:3000'",
  --           url = "http://localhost:3000",
  --           webRoot = "${workspaceFolder}",
  --           userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
  --         },
  --         {
  --           type = "pwa-chrome",
  --           request = "launch",
  --           name = "Start Chrome with 'localhost:3001'",
  --           url = "http://localhost:3001",
  --           webRoot = "${workspaceFolder}",
  --           userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
  --         },
  --         {
  --           type = "pwa-chrome",
  --           request = "launch",
  --           name = "Start Chrome with 'localhost:3002'",
  --           url = "http://localhost:3002",
  --           webRoot = "${workspaceFolder}",
  --           userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
  --         },
  --         {
  --           type = "pwa-chrome",
  --           request = "launch",
  --           name = "Start Chrome with 'localhost:4000'",
  --           url = "http://localhost:4000",
  --           webRoot = "${workspaceFolder}",
  --           userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
  --         },
  --         {
  --           type = "pwa-chrome",
  --           request = "launch",
  --           name = "Start Chrome with 'localhost:4001'",
  --           url = "http://localhost:4001",
  --           webRoot = "${workspaceFolder}",
  --           userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
  --         },
  --         {
  --           type = "pwa-chrome",
  --           request = "launch",
  --           name = "Start Chrome with 'localhost:4002'",
  --           url = "http://localhost:4002",
  --           webRoot = "${workspaceFolder}",
  --           userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
  --         },
  --         {
  --           type = "pwa-chrome",
  --           request = "launch",
  --           name = "Start Chrome with 'localhost:8081'",
  --           url = "http://localhost:8081/debugger-ui/",
  --           webRoot = "${workspaceFolder}",
  --           userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
  --         },
  --       }
  --     end
  --   end,
  --   event = 'LspAttach'
  -- },
  {
    'ThePrimeagen/harpoon',
    config = function ()
      require("telescope").load_extension("harpoon")
    end,
  },
  {
    'folke/trouble.nvim',
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup({
        gh_env = {
          GITHUB_TOKEN = vim.env.GITHUB_TOKEN_ZB,
        },
      })
      vim.treesitter.language.register("markdown", "octo")
    end,
    event = "VeryLazy",
  },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup({
        filetype = {
          'markdown',
          'vimwiki',
        },
        theme = 'light',
      })

      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
    event = {
      "VeryLazy"
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/playground',
    },
    opts = {
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = {
          "BufWrite",
          "CursorHold"
        },
      },
    },
  },
  {
    'crusj/bookmarks.nvim',
    branch = 'main',
    dependencies = { 'nvim-web-devicons' },
    config = function()
      require("bookmarks").setup({
        keymap = {
          toggle = "<F3>",
        },
        sign_icon = "🌺",
        width = 0.9,
        height = 0.9,
      })
      require("telescope").load_extension("bookmarks")
    end,
    event = "VeryLazy",
  },
  -- default config
  {
    "vhyrro/luarocks.nvim",
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" },
    },
  },
  {
    '3rd/image.nvim',
    branch = 'master',
    dependencies = {
      "luarocks.nvim",
    },
    config = function()
      require("image").setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = true,
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
          },
          html = {
            enabled = false,
          },
          css = {
            enabled = false,
          },
        },
        max_width = 100, -- tweak to preference
        max_height = 20, -- ^
        max_height_window_percentage = math.huge, -- this is necessary for a good experience
        max_width_window_percentage = math.huge,
        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        -- max_width = nil,
        -- max_height = nil,
        -- max_width_window_percentage = nil,
        -- max_height_window_percentage = 50,
        -- window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
        -- window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
      })
    end,
    event = 'VeryLazy',
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = {
      "3rd/image.nvim",
    },
    build = ":UpdateRemotePlugins",
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
    end,
    event = 'VeryLazy',
  },
  {
    'deptno/gx.nvim',
    -- dir = '/Users/deptno/workspace/src/github.com/deptno/gx.nvim',
    config = function ()
      require('gx').setup({})
    end,
    event = 'VeryLazy',
  }
}
