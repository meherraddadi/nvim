return {
  "ErichDonGubler/lsp_lines.nvim",
  config = function()
    -- Disable virtual_text since it's redundant due to lsp_lines.
    vim.diagnostic.config({
      virtual_text = false,
    })
    vim.diagnostic.config({ virtual_lines = true })
  end
}
