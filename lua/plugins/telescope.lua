return {
  "nvim-telescope/telescope.nvim",
  branch = "master", -- using master to fix issues with deprecated to definition warnings
  -- '0.1.x' for stable ver.
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "andrew-george/telescope-themes",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    telescope.load_extension("fzf")
    telescope.load_extension("themes")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        live_grep = {
          additional_args = { "--hidden" },
        },
      },
      extensions = {
        themes = {
          enable_previewer = true,
          enable_live_preview = true,
          persist = {
            enabled = true,
            path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua",
          },
        },
      },
    })


    --Keymaps
    -- Rechercher dans les buffers ouverts
    vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'Find Buffers' })
    vim.keymap.set('n', '<C-p>', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set("n", "<leader>pr", function()
      builtin.oldfiles({ cwd_only = true })
    end, { desc = "Fuzzy find recent files (cwd only)" })
    -- vim.keymap.set("n", "<leader>ps", function() require("snacks").picker.grep() end, desc = "Grep word" })

    vim.keymap.set("n", "<leader>pWs", function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end, { desc = "Find Connected Words under cursor" })

    vim.keymap.set("n", "<leader>ths", "<cmd>Telescope themes<CR>",
      { noremap = true, silent = true, desc = "Theme Switcher" })
  end,
}
