-- return {
--   {
--     "catppuccin/nvim",
--     lazy = false,
--     name = "catppuccin",
--     priority = 1000,
--     config = function()
--       vim.cmd.colorscheme "catppuccin-mocha"
--       integrations = {
--         toggleterm = true,
--         treesitter = true,
--         native_lsp = { enabled = true },
--         cmp = true,
--       }
--     end
--   }
-- }
return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        integrations = {
          -- toggleterm = true,
          treesitter = true,
          native_lsp = {
            enabled = true,
          },
          cmp = true,
        },
      })
      vim.cmd.colorscheme "catppuccin-mocha"
    end
  }
}

