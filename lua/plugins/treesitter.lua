return {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			insure_installed = {"lua","javascript","terraform"},
			highlight = {enable = true},
			indent = {enable = true},
		})
	end
}

