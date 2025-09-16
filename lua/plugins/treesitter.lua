return {"nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  cmd = {"TSInstall", "TSUpdate", "TSEnable"}, -- Déclencheur manuel
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {"lua","javascript","terraform"},
      highlight = {enable = true},
      indent = {enable = true},
    })
  end
}
