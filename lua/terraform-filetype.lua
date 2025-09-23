-- Ensure tfvars files are detected correctly
vim.filetype.add({
  extension = {
    tfvars = "terraform",
    tf = "terraform",
  },
  filename = {
    [".terraformrc"] = "terraform",
    ["terraform.rc"] = "terraform",
  },
})