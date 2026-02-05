# AGENTS.md

## Project Overview
This project is a highly customized Neovim configuration designed for maintainability and supporting a wide array of developer workflows. It utilizes `Lazy.nvim` as the plugin manager and organizes its settings and plugins into modular Lua files for clarity and reusability.

## Directory Structure
```
init.lua                    # Entry point for configuration, loads core and plugin modules
lua/
├── current-theme.lua       # Configures the fallback colorscheme
├── debug-terraform.lua     # Command to debug terraform file formatting sources
├── terraform-filetype.lua  # Adds support for terraform and tfvars filetypes
├── vim-options.lua         # Core Vim options (+ keybindings, leader, tab config)
└── plugins/                # One file per plugin for better modularity
```

## Plugin Management
The `lua/plugins/` directory contains **Lazy.nvim specs** for plugin configurations. Each plugin file employs the Lazy.nvim table schema to define plugin settings, dependencies, and lazy-loading conditions where applicable.

### Key Plugin Files:
- `alpha.lua`: Sets up a stylish dashboard powered by Alpha.nvim.
- `avante.lua`: Configures the Avante plugin for AI-powered suggestions using GPT models.
- `bufferline.lua`: Displays buffer tabs with enhanced controls, including mouse actions and shortcuts.
- `completions.lua`: Manages `nvim-cmp`, integration for autocompletion sources like LSP and snippets.
- `lsp-config.lua`: Configures various language servers (e.g., TypeScript, Lua, YAML) via the built-in LSP client.
- `telescope.lua`: Provides fuzzy finding and search capabilities with extensibility from Telescope plugins.
- `treesitter.lua`: Improves code highlighting and parsing support for multiple languages with Treesitter.

## Notable Features
### Core Settings (vim-options.lua)
- Sets `tabstop`, `shiftwidth`, and `softtabstop` to 2 spaces for consistent indentation.
- Maps `<C-h/j/k/l>` to navigate between Vim splits.
- Leader key is set to space(` `).
- Buffer convenience commands include `<leader>q` to close a buffer and `<leader>bo` for closing all other buffers.

### Terraform Support
- `terraform-filetype.lua`
  - Ensures `.tf` and `.tfvars` detect as Terraform filetypes.
- `debug-terraform.lua`
  - Adds a `:DebugTerraform` command for listing available formatters.

### IntelliJ-AI Integration
- `copilot-chat.lua` combines Copilot and Claude for AI development assistance.
- `avante.lua` provisions GPT model hints for better language support.

## Development Tips
### Adding New Plugins
1. Create a new file in `lua/plugins/` (e.g., `lua/plugins/my-plugin.lua`).
2. Follow the Lazy.nvim spec structure:
```lua
return {
  {
    "owner/repo",
    dependencies = {...},
    opts = {...},
    config = function() ... end,
  }
}
```
3. The plugin will be auto-installed and activated after a lazy sync (`:Lazy sync`).

### Commands
Key custom commands include:
- `:Lazy`: Opens Lazy.nvim's interface for plugin management.
- `:Mason`: Displays installed Language Servers, Linters, and Formatters.
- `:LspInfo`: Lists all active LSPs.
- `:DebugTerraform`: Troubleshoots Terraform file formatting.

### Debugging
- Use `:messages` to view any plugin or Neovim startup errors.
- Check paths for compatibility issues by inspecting Lazy.nvim logs (`~/.local/share/nvim/lazy.log`).

By following the modular approach of this configuration, developers can easily add new plugins, customize existing setups, and debug language-specific workflows. Future maintainers should review this document and the plugin specs for seamless continuity.

