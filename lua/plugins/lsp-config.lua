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
    opts = {
      --auto_install = true,
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.solargraph.setup({
        capabilities = capabilities,
      })
      lspconfig.html.setup({
        capabilities = capabilities,
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.intelephense.setup({
        capabilities = capabilities,
        settings = {
          intelephense = {
            format = {
              enable = true,
            },
          },
        },
      })
      
      -- Configure YAML Language Server with Kubernetes schemas
      lspconfig.yamlls.setup({
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
      -- Configure Terraform LS with log silencing
      lspconfig.terraformls.setup({
        capabilities = capabilities,
        filetypes = { "terraform", "hcl", "tf", "tfvars" },
        on_attach = function(client, bufnr)
          -- Enable advanced module resolution
          client.config.settings = {
            terraform = {
              enableModuleResolution = true, -- Critical for jumping to modules
              lsp = {
                logLevel = "Error",          -- Keep your log silencing
              },
            },
          }

          -- Keymaps for Terraform files only
          vim.keymap.set("n", "gd", function()
            vim.lsp.buf.definition({ reuse_win = true }) -- Jump without splitting
          end, { buffer = bufnr, desc = "[G]oto [D]efinition" })

          vim.keymap.set(
            "n",
            "gD",
            vim.lsp.buf.declaration,
            { buffer = bufnr, desc = "[G]oto [D]eclaration" }
          )
        end,
        root_dir = lspconfig.util.root_pattern("*.tf", "*.tfvars", ".terraform", ".git"), -- Better project detection
      })

      -- Configure TFLint with explicit args
      -- lspconfig.tflint.setup({
      --   capabilities = capabilities,
      --   filetypes = { "terraform", "hcl", "tf" },
      --   cmd = {
      --     "tflint",
      --     "--langserver",
      --     "--config",
      --     "$ROOT/.tflint.hcl",                  -- Use project-specific config
      --     "--enable-rule=aws_instance_invalid_type", -- Example rule
      --   },
      -- })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
