-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require("lspconfig")
local servers = {
  "rust_analyzer",
  "tsserver",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local cfg = require("yaml-companion").setup({
  on_attach = on_attach,
  capabilities = capabilities,
  -- Built in file matchers
  builtin_matchers = {
    -- Detects Kubernetes files based on content
    kubernetes = { enabled = true },
    cloud_init = { enabled = true }
  },

  -- Additional schemas available in Telescope picker
  schemas = {
    {
      name = "Kubernetes 1.26,0",
      uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.26.0-standalone-strict/all.json",
    },
    {
      name = "Azure pipeline",
      uri = "https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"
    }
  },

  -- Pass any additional options that will be merged in the final LSP config
  lspconfig = {
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      redhat = { telemetry = { enabled = false } },
      yaml = {
        validate = true,
        format = { enable = true },
        hover = true,
        schemaStore = {
          enable = true,
          url = "https://www.schemastore.org/api/json/catalog.json",
        },
        schemaDownload = { enable = true },
        schemas = {},
        trace = { server = "debug" },
      },
    },
  },
})
lspconfig.yamlls.setup(cfg)
lspconfig.jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = {
        {
          description = "NPM configuration file",
          fileMatch = {
            "package.json",
          },
          url = "https://json.schemastore.org/package.json",
        },
        {
          description = "TypeScript compiler configuration file",
          fileMatch = {
            "tsconfig.json",
            "tsconfig.*.json",
          },
          url = "https://json.schemastore.org/tsconfig.json",
        },
      },
      validate = { enable = true },
    }
  }
})
