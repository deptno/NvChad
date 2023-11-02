return {
  {
    "neovim/nvim-lspconfig",
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
    config = function()
      require("custom.configs.vimwiki")
    end,
    ft = { "markdown" },
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
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      'nvim-treesitter/nvim-treesitter'
    },
    config = function ()
      local fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, {suffix, 'MoreMsg'})
        return newVirtText
      end
      require('ufo').setup({
        fold_virt_text_handler = fold_virt_text_handler,
      })
    end,
    event = 'VeryLazy'
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
    "nvimdev/guard.nvim",
    dependencies = {
      "nvimdev/guard-collection",
    },
    config = function ()
      local ft = require('guard.filetype')

      ft('typescript,javascript,javascriptreact,typescriptreact')
        :lint('eslint_d')
        :fmt('prettier')

      require('guard').setup({
        lsp_as_default_formatter = false,
      })
    end,
    event = 'LspAttach',
  },
}
