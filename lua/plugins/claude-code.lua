return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("claude-code").setup({
      command = "claude -c",
      window = {
        position = "botright vertical",
        width = 50,
      },
    })
  end,
  keys = {
    { "<leader>co", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude Code" },
  },
}
