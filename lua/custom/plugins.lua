return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local chad = require("plugins.configs.telescope")
      local custom = require("custom.configs.telescope")
      local merged = vim.tbl_deep_extend("force", chad, custom)

      return merged
    end,
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
    opts = {},
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
  }
}
