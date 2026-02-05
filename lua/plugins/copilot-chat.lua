-- Lazy
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      model = "gpt-4",
      auto_insert_mode = true,
      show_help = true,
      question_header = "## User ",
      answer_header = "## Copilot ",
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      chat.setup(opts)
      
      -- Keymaps pratiques
      vim.keymap.set('n', '<leader>cc', ':CopilotChat<CR>', { desc = 'Copilot Chat' })
      vim.keymap.set('n', '<leader>cm', ':CopilotChatCommit<CR>', { desc = 'Generate commit message' })

      vim.keymap.set('v', '<leader>ce', ':CopilotChatExplain<CR>', { desc = 'Explain code' })
      vim.keymap.set('v', '<leader>cf', ':CopilotChatFix<CR>', { desc = 'Fix code' })
    end,
  },
}
