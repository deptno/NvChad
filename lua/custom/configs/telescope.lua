return {
  defaults = {
    layout_strategy = 'bottom_pane',
    layout_config = {
      -- vertical = {
      --   width = 0.95
      -- },
      -- height = 0.95,
      -- preview_cutoff = nil,
      -- prompt_position = "top",
      height = .85,
      -- preview_cutoff = 120,
      prompt_position = "bottom",
    },
    prompt_prefix = " 🐮 ",
    path_display = {
      shorten = 2,
    },
    dynamic_preview_title = true, -- preview 에 파일명 표시
    preview = {
      filesize_limit = 1
    },
    sorting_strategy = "descending",
    -- file_ignore_patterns
    mappings = {
      i = { ["<c-t>"] = require("trouble.sources.telescope").open },
      n = { ["<c-t>"] = require("trouble.sources.telescope").open },
    },
  },
  pickers = {
    find_files = { theme = 'ivy' },
    oldfiles = { cwd_only = true },
    live_grep = {},
  },
  extensions = {
    ["ui-select"] = {
      -- @see https://github.com/nvim-telescope/telescope-ui-select.nvim#telescope-setup-and-configuration
      require("telescope.themes").get_cursor({})
    },
    persisted = {
      layout_strategy = 'center',
      layout_config = {
        height = 20,
        width = 100,
      }
    }
  }
}
