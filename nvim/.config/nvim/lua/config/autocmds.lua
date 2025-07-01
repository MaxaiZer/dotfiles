vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.wo.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.wo.relativenumber = true
  end,
})
