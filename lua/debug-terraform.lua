-- Debug script for terraform formatting
vim.api.nvim_create_user_command('DebugTerraform', function()
  local buf = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[buf].filetype
  local filename = vim.api.nvim_buf_get_name(buf)
  
  print("Debug info:")
  print("Filename: " .. filename)
  print("Filetype: " .. filetype)
  print("Available formatters:")
  
  local null_ls = require("null-ls")
  local sources = null_ls.get_sources({ filetype = filetype, method = null_ls.methods.FORMATTING })
  
  for _, source in ipairs(sources) do
    print("- " .. source.name)
  end
  
  if #sources == 0 then
    print("No formatters found for filetype: " .. filetype)
  end
end, {})