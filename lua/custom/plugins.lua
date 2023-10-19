return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
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
    init = function()
      require("cmp_git").setup(require("custom.configs.cmp_git"))
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      local opt = require("plugins.configs.others").gitsigns
      opt.numhl = true

      return opt
    end,
  },
  {
    "vimwiki/vimwiki",
    lazy = false,
    init = function()
      require("custom.configs.vimwiki")
    end,
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
    event = "VeryLazy",
    config = function ()
      require("nvim-surround").setup({})
    end
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
  },
  {
    "sindrets/diffview.nvim",
    init = function ()
      local config = require("custom.configs.diffview")
      require("diffview").setup(config)
    end
  },
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    init = function ()
      local config = require("custom.configs.rest")
      require("rest-nvim").setup(config)
    end
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
    init = function ()
      require('neogit').setup()
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    init = function ()
      require("symbols-outline").setup(require('custom.configs.symbols-outline'))
    end
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
    event = 'VeryLazy',
    opts = {
      default_mappings = true,
      builtin_marks = { ".", "<", ">", "^" },
      cyclic = true,
      force_write_shada = false,
      refresh_interval = 250,
      sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
      excluded_filetypes = {},
      bookmark_1 = { sign = "1", virt_text = "🐮 1", annotate = false },
      bookmark_2 = { sign = "2", virt_text = "🐮 2", annotate = false },
      bookmark_3 = { sign = "3", virt_text = "🐮 3", annotate = false },
      bookmark_4 = { sign = "4", virt_text = "🐮 4", annotate = false },
      bookmark_5 = { sign = "5", virt_text = "🐮 5", annotate = false },
      bookmark_6 = { sign = "6", virt_text = "🐮 6", annotate = false },
      bookmark_7 = { sign = "7", virt_text = "🐮 7", annotate = false },
      bookmark_8 = { sign = "8", virt_text = "🐮 8", annotate = false },
      bookmark_9 = { sign = "9", virt_text = "🐮 9", annotate = false },
      bookmark_0 = { sign = "🐮", virt_text = "🐮 @", annotate = false },
      mappings = {
        next_bookmark1 = "]1",
        prev_bookmark1 = "[1",
        next_bookmark2 = "]2",
        prev_bookmark2 = "[2",
        next_bookmark3 = "]3",
        prev_bookmark3 = "[3",
        next_bookmark4 = "]4",
        prev_bookmark4 = "[4",
        next_bookmark5 = "]5",
        prev_bookmark5 = "[5",
        next_bookmark6 = "]6",
        prev_bookmark6 = "[6",
        next_bookmark7 = "]7",
        prev_bookmark7 = "[7",
        next_bookmark8 = "]8",
        prev_bookmark8 = "[8",
        next_bookmark9 = "]9",
        prev_bookmark9 = "[9",
        next_bookmark0 = "]0",
        prev_bookmark0 = "[0",
        next_bookmark = "]`",
        prev_bookmark = "[`",
        annotate = "mm",
      }
    }
  }
}
