return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- Formatting
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.terraform_fmt.with({
					filetypes = { "terraform", "hcl", "tf" },
				}),
				-- YAML formatting
				null_ls.builtins.formatting.yamlfmt,
				-- PHP formatting
				null_ls.builtins.formatting.phpcsfixer,
				-- Alternative PHP formatter (if php-cs-fixer is not available)
				-- null_ls.builtins.formatting.phpcbf,

				-- Diagnostics
				null_ls.builtins.diagnostics.terraform_validate.with({
					filetypes = { "terraform", "hcl", "tf" },
				}),
			},
		})

		-- Format keybinding
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
