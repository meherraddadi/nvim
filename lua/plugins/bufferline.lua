-- ~/.config/nvim/lua/plugins.lua (or similar)
return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "tabs",                  --"buffers", -- set to "tabs" if you prefer tab-style
          numbers = "none",            --"none", -- "ordinal" | "buffer_id"
          close_command = "bdelete! %d",  -- close a buffer without messing layout
          right_mouse_command = "bdelete! %d", -- right-click to close
          left_mouse_command = "buffer %d", -- left-click to switch
          middle_mouse_command = nil,     -- middle-click to close (set to same as right if needed)
          indicator = {
            style = "icon",               --"underline", -- or 'icon' | 'none'
          },
          buffer_close_icon = "",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 18,
          max_prefix_length = 15,
          truncate_names = true,
          tab_size = 18,
          diagnostics = "nvim_lsp", -- "false" | "nvim_lsp" | "coc"
          diagnostics_update_in_insert = false,
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          separator_style = "thin", -- "slant" | "thick" | "thin" | { 'any', 'any' }
          enforce_regular_tabs = false,
          always_show_bufferline = true,
          -- diagnostics = 'coc',
         offsets = {
            {
              filetype = "neo-tree",
              text = "",
              highlight = "Directory",
              separator = true,
              text_align = "left",
            }
          },
        },
      })
      -- ===== Keymaps =====
      local map = vim.keymap.set
      local opts = { silent = true, noremap = true }

      -- Cycle through buffers
      map("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", opts)
      map("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", opts)

      -- Close buffer
      map("n", "<leader>x", "<Cmd>bdelete<CR>", opts)

      -- Reorder buffers
      map("n", "<leader>bl", "<Cmd>BufferLineMoveNext<CR>", opts)
      map("n", "<leader>bh", "<Cmd>BufferLineMovePrev<CR>", opts)

      -- Pick buffers
      map("n", "<leader>bp", "<Cmd>BufferLinePick<CR>", opts)
      map("n", "<leader>bP", "<Cmd>BufferLinePickClose<CR>", opts)
    end,
  },
}
