return {
  "someone-stole-my-name/yaml-companion.nvim",
  ft = { "yaml", "yml" },
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("telescope").load_extension("yaml_schema")

    vim.keymap.set("n", "<leader>ys", "<cmd>Telescope yaml_schema<CR>", { desc = "Switch YAML schema" })
  end,
}
