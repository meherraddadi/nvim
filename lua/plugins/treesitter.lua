return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local config = require("nvim-treesitter.config")
    config.setup({
      ensure_installed = {
        "lua",
        "terraform",
        "hcl",
        "yaml",
        "json",
        "bash",
        "dockerfile",
        "markdown",
        "javascript",
      },
      highlight = { enable = true },
      indent = { enable = true },
      sync_install = false,
      auto_install = true,
    })
  end,
}
