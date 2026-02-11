-- ~/.config/nvim/lua/plugins/toggleterm.lua
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      -- ===== Basic Settings =====
      size = 25,
      open_mapping = [[<leader>tt]], -- Main toggle (disable if using custom keymaps)
      direction = "horizontal",      -- "horizontal" | "vertical" | "tab" | "float"
      shade_terminals = true,
      persist_size = true,
      close_on_exit = true,

      -- ===== Terminal Appearance =====
      float_opts = {
        border = "rounded", -- "single" | "double" | "shadow" | "curved"
        winblend = 0,       -- Transparency (0-100, integer)
      },
    })

    -- ===== Custom Keymaps =====
    local Terminal = require("toggleterm.terminal").Terminal
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Toggle the main terminal
    map("n", "<leader>tt", "<cmd>ToggleTerm<CR>", opts)

    -- Directional Terminals (create if doesn't exist, toggle otherwise)
    local horizontal_term = Terminal:new({ direction = "horizontal" })
    local vertical_term = Terminal:new({ direction = "vertical" })
    local float_term = Terminal:new({ direction = "float" })

    map("n", "<leader>th", function() horizontal_term:toggle() end, opts)
    map("n", "<leader>tv", function() vertical_term:toggle() end, opts)
    map("n", "<leader>tf", function() float_term:toggle() end, opts)

    -- Send commands to terminal (e.g., run current file)
    map("n", "<leader>tr", function()
      local filetype = vim.bo.filetype
      local file = vim.fn.expand("%")
      local cmd = ({
        python = "python " .. file,
        lua = "lua " .. file,
        sh = "bash " .. file,
        javascript = "node " .. file,
      })[filetype] or "echo 'Unsupported filetype'"
      float_term:send(cmd)
    end, opts)

    -- Send visual selection to terminal
    map("v", "<leader>ts", function()
      float_term:send(vim.fn.getreg('"')) -- Send last yanked text
    end, opts)

    -- Lazygit integration (requires lazygit installed)
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      hidden = true,
    })
    map("n", "<leader>tg", function() lazygit:toggle() end, opts)

    -- Claude Code CLI integration
    map("n", "<leader>ai", "<cmd>TermExec cmd='claude -c' direction=float<CR>", { desc = "Claude Code CLI" })
    -- Toggle last terminal (overrides default <C-\> if needed)
    map("n", "<C-\\>", "<cmd>ToggleTerm<CR>", { desc = "Toggle last terminal" })

    -- Fix space latency in terminal (leader key conflict)
    map("t", "<Space>", "<Space>", { nowait = true, desc = "Send space immediately" })

    -- Terminal mode navigation
    map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" }) -- Return to Normal mode
    map("t", "<Esc><Esc>", "<C-\\><C-n><cmd>q<CR>", { desc = "Close terminal" }) -- Close terminal
    map("t", "<C-h>", "<Cmd>wincmd h<CR>", { desc = "Move left from terminal" })
    map("t", "<C-j>", "<Cmd>wincmd j<CR>", { desc = "Move down from terminal" })
    map("t", "<C-k>", "<Cmd>wincmd k<CR>", { desc = "Move up from terminal" })
    map("t", "<C-l>", "<Cmd>wincmd l<CR>", { desc = "Move right from terminal" })

    -- Optional: Add window navigation in Normal mode for consistency
    map("n", "<C-h>", "<Cmd>wincmd h<CR>", { desc = "Move left" })
    map("n", "<C-j>", "<Cmd>wincmd j<CR>", { desc = "Move down" })
    map("n", "<C-k>", "<Cmd>wincmd k<CR>", { desc = "Move up" })
    map("n", "<C-l>", "<Cmd>wincmd l<CR>", { desc = "Move right" })
  end,
}
