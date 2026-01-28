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
    dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Servers with default config
      local simple_servers = { "ts_ls", "solargraph", "html", "lua_ls" }
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

      -- YAML Language Server with Kubernetes schemas
      vim.lsp.config("yamlls", {
        capabilities = capabilities,
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = {
                "/*.k8s.yaml",
                "/*.k8s.yml",
                "/k8s/*.yaml",
                "/k8s/*.yml",
                "/kubernetes/*.yaml",
                "/kubernetes/*.yml",
                "/**/k8s/**/*.yaml",
                "/**/k8s/**/*.yml",
                "/**/kubernetes/**/*.yaml",
                "/**/kubernetes/**/*.yml",
                "deployment.yaml",
                "deployment.yml",
                "service.yaml",
                "service.yml",
                "configmap.yaml",
                "configmap.yml",
                "secret.yaml",
                "secret.yml",
                "ingress.yaml",
                "ingress.yml",
                "pod.yaml",
                "pod.yml",
                "namespace.yaml",
                "namespace.yml"
              },
              ["https://json.schemastore.org/kustomization.json"] = "kustomization.yaml",
              ["https://json.schemastore.org/chart.json"] = "Chart.yaml"
            },
            validate = true,
            completion = true,
            hover = true,
            schemaStore = {
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
      vim.lsp.enable({ "ts_ls", "solargraph", "html", "lua_ls", "intelephense", "yamlls", "terraformls" })

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
