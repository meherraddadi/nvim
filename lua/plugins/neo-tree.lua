return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    --require("neo-tree").setup({
    --  windows = {
    --    position = "right",   -- Position of the Neo-tree window
    --    width = 40,           -- Width of the Neo-tree window
    --    auto_expand_width = true, -- Automatically expand the width of the Neo-tree window
    --  },
    --  source_selector = {
    --    winbar = false,
    --    statusline = false,
    --  },
    --  filesystem = {
    --    filtered_items = {
    --      visible = true,
    --      show_hidden = true,
    --      hide_dotfiles = false,
    --      hide_by_name = {
    --        --"node_modules" -- Exemple : seul "node_modules" est caché explicitement
    --      },
    --      hide_by_pattern = { -- Aucun masquage par motif
    --        --"*.meta",
    --        --"*/src/*/tsconfig.json",
    --      },
    --    },
    --  },
    --  sources = {
    --    "filesystem",
    --    "buffers",
    --    "git_status",
    --    "example", -- <-- external sources need to be a fully qualified path to the module
    --    --"my.name.example" <-- Feel free to add to your folder structure to create a namespace,
    --    -- The name of the source will be the last part, or whatever your module
    --    -- exports as the `name` field.
    --  },
    --})
    require("neo-tree").setup({
      sources = {
        "filesystem", -- Navigateur de fichiers
        "buffers", -- Buffers ouverts
        "git_status", -- État Git
      },
      source_selector = {
        winbar = true, -- Si tu veux dans la winbar
        statusline = false, -- Ou dans la statusline
        show_scrolled_off_parent_node = false,
        sources = {
          { source = "filesystem", display_name = "󰉓 Files" },
          { source = "buffers", display_name = "󰈚 Buffers" },
          { source = "git_status", display_name = " Git" },
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        hijack_netrw_behavior = "open_default",
        filtered_items = {
          visible = false,
          hide_dotfiles = true,
          hide_gitignored = true,
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true,
        },
      },
      git_status = {
        window = {
          position = "float", -- ou "left"/"right" si tu préfères l'intégrer
        },
      },
      window = {
        position = "left",
        -- width = 40,
      },
    })

    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle source=filesystem<CR>", { desc = "Explorer Files" })
    vim.keymap.set("n", "<leader>b", "<cmd>Neotree toggle source=buffers<CR>", { desc = "Buffers List" })
    vim.keymap.set("n", "<leader>g", "<cmd>Neotree toggle source=git_status<CR>", { desc = "Git Status" })

    vim.keymap.set("n", "<C-n>", ":Neotree filesystem toggle left<CR>", {})
    vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
  end,
}
