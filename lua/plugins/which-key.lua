return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 300,
    icons = {
      breadcrumb = ">>",
      separator = "->",
      group = "+",
    },
    spec = {
      { "<leader>g", group = "Git/LSP" },
      { "<leader>p", group = "Picker/Search" },
      { "<leader>t", group = "Terminal" },
      { "<leader>x", group = "Diagnostics" },
      { "<leader>b", group = "Buffers" },
      { "<leader>c", group = "Copilot/Code" },
      { "<leader>l", group = "Lazy" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps",
    },
  },
}
