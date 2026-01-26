# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration using **Lazy.nvim** as the plugin manager. The configuration is modular with individual plugin files in `lua/plugins/`.

## Structure

```
init.lua                    # Entry point: bootstraps Lazy.nvim, loads vim-options & plugins
lua/
├── vim-options.lua         # Core settings: tabs (2 spaces), leader (Space), keybindings
├── terraform-filetype.lua  # Terraform .tf/.tfvars detection
├── debug-terraform.lua     # :DebugTerraform command for formatter troubleshooting
├── current-theme.lua       # Colorscheme fallback
└── plugins/                # One file per plugin (Lazy spec format)
```

## Plugin Configuration Pattern

Each plugin in `lua/plugins/` returns a Lazy spec table:
```lua
return {
  {
    "owner/plugin-name",
    dependencies = {...},
    config = function() ... end,
    opts = {...},
    keys = {...},
  }
}
```

## Key Components

| Component | File | Purpose |
|-----------|------|---------|
| LSP | `lsp-config.lua` | ts_ls, solargraph, lua_ls, intelephense, yamlls, terraformls |
| Formatting | `none-ls.lua` | stylua, prettier, black, isort, terraform_fmt, yamlfmt, phpcsfixer |
| Completion | `completions.lua` | nvim-cmp with LSP, LuaSnip, buffer, path sources |
| File Nav | `telescope.lua`, `neo-tree.lua` | Fuzzy finder and file explorer |
| Git | `gitstuff.lua` | vim-fugitive + gitsigns |
| AI | `avante.lua`, `copilot-chat.lua` | Claude and Copilot integrations |
| UI | `catppuccin.lua`, `lualine.lua`, `bufferline.lua` | Theme and status displays |

## Essential Keybindings

| Key | Action |
|-----|--------|
| `<C-p>` | Find files (Telescope) |
| `<C-n>` | Toggle Neo-tree |
| `<leader>fg` | Live grep |
| `<leader>gf` | Format buffer |
| `<leader>gd` | Go to definition |
| `<leader>gr` | Find references |
| `<leader>ca` | Code actions |
| `<leader>gg` | Open Fugitive |
| `<leader>tt` | Toggle terminal |
| `<leader>lg` | Lazygit |
| `<Tab>/<S-Tab>` | Cycle buffers |
| `<leader>x` | Close buffer |
| `]h/[h` | Next/prev git hunk |

## Commands

- `:Lazy` - Plugin manager UI
- `:Mason` - LSP/formatter installer
- `:LspInfo` - Check LSP status
- `:DebugTerraform` - Show available formatters for current filetype

## Adding New Plugins

Create a new file in `lua/plugins/` (e.g., `lua/plugins/my-plugin.lua`) following the Lazy spec pattern. The plugin will be automatically loaded.

## Language-Specific Notes

- **Terraform**: Custom filetype detection, terraformls with module resolution, terraform_fmt
- **YAML/K8s**: yamlls with extensive schema validation (GitHub Actions, Kubernetes, Helm)
- **PHP**: intelephense LSP with php-cs-fixer formatting
