return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp", "b0o/schemastore.nvim" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Servers with default config
      local simple_servers = { "ts_ls", "solargraph", "html", "lua_ls", "dockerls", "bashls" }
      for _, server in ipairs(simple_servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
      end

      -- Intelephense with custom settings
      vim.lsp.config("intelephense", {
        capabilities = capabilities,
        settings = {
          intelephense = {
            format = {
              enable = true,
            },
          },
        },
      })

      -- YAML Language Server with SchemaStore + Kubernetes schemas
      vim.lsp.config("yamlls", {
        capabilities = capabilities,
        settings = {
          yaml = {
            schemas = require("schemastore").yaml.schemas({
              extra = {
                -- Kubernetes schemas (v1.31 - up to date)
                {
                  name = "Kubernetes",
                  description = "Kubernetes resource definitions",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.31.0-standalone-strict/all.json",
                  fileMatch = {
                    "/*.k8s.yaml", "/*.k8s.yml",
                    "/k8s/*.yaml", "/k8s/*.yml",
                    "/kubernetes/*.yaml", "/kubernetes/*.yml",
                    "/**/k8s/**/*.yaml", "/**/k8s/**/*.yml",
                    "/**/kubernetes/**/*.yaml", "/**/kubernetes/**/*.yml",
                    "deployment.yaml", "deployment.yml",
                    "service.yaml", "service.yml",
                    "configmap.yaml", "configmap.yml",
                    "secret.yaml", "secret.yml",
                    "ingress.yaml", "ingress.yml",
                    "pod.yaml", "pod.yml",
                    "namespace.yaml", "namespace.yml",
                  },
                },
              },
            }),
            validate = true,
            completion = true,
            hover = true,
            schemaStore = {
              -- Disable built-in schemaStore, using b0o/schemastore.nvim instead
              enable = false,
              url = "",
            },
            customTags = {
              "!reference sequence",
              "!Ref",
              "!Condition",
              "!GetAtt",
              "!Sub",
              "!Join",
              "!Base64",
              "!ImportValue",
              "!Select",
              "!Split",
              "!FindInMap sequence"
            }
          }
        },
        filetypes = { "yaml", "yml" }
      })

      -- Helm LS
      vim.lsp.config("helm_ls", {
        capabilities = capabilities,
        filetypes = { "helm" },
        settings = {
          ["helm-ls"] = {
            yamlls = {
              path = "yaml-language-server",
            },
          },
        },
      })

      -- Terraform LS
      vim.lsp.config("terraformls", {
        capabilities = capabilities,
        filetypes = { "terraform", "hcl", "tf", "tfvars" },
        settings = {
          terraform = {
            enableModuleResolution = true,
            lsp = {
              logLevel = "Error",
            },
          },
        },
      })

      -- Enable all configured servers
      vim.lsp.enable({ "ts_ls", "solargraph", "html", "lua_ls", "intelephense", "yamlls", "helm_ls", "terraformls", "dockerls", "bashls" })

      -- Global LSP keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

      -- Terraform-specific keymaps via autocommand
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "terraform", "hcl", "tf", "tfvars" },
        callback = function(args)
          vim.keymap.set("n", "gd", function()
            vim.lsp.buf.definition({ reuse_win = true })
          end, { buffer = args.buf, desc = "[G]oto [D]efinition" })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf, desc = "[G]oto [D]eclaration" })
        end,
      })
    end,
  },
}
