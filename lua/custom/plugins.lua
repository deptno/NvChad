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
      local chad = require("plugins.configs.others").blankline      local custom = require("custom.configs.indent-blankline")
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
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function (_, opts)
      require("rest-nvim").setup(require("custom.configs.rest"), opts)
    end,
    ft = { 'http' }
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
    config = function (_, opts)
      require('neogit').setup({}, opts)
    end,
    event = 'VeryLazy',
  },
  {
    "simrat39/symbols-outline.nvim",
    opts = require('custom.configs.symbols-outline'),
    config = function (_, opts)
      require("symbols-outline").setup(opts)
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
    opts = require('custom/configs/marks'),
    event = 'VeryLazy',
  }
}
