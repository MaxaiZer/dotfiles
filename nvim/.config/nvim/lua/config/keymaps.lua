vim.keymap.set("n", "<C-a>", "gg0vG$", { desc = "Select all" })
vim.keymap.set("n", "<C-q>", ":qa<CR>", { desc = "Quit all" })
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })

vim.keymap.set("n", "<M-Right>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<M-Left>", ":bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<Space>/", function()
  require("telescope").extensions.live_grep_args.live_grep_args({
    layout_strategy = "vertical",
    path_display = { "smart" },
    wrap_results = true,
    disable_coordinates = true,
    layout_config = {
      horizontal = {
        width = 9999,
        height = 9999,
        prompt_position = "bottom",
        results_width = 0.35,
        preview_width = 0.65,
      },
      vertical = {
        width = 9999,
        height = 9999,
        preview_height = 0.4,
        preview_cutoff = 0,
      },
    },
  })
end, { desc = "Live Grep" })
vim.keymap.set("n", "<Space>r/", ":Telescope resume<CR>", { desc = "Telescope resume" })

vim.keymap.set("n", "<leader>gg", ":Neogit<CR>", { desc = "Neogit" })

vim.keymap.set("n", "<leader>gB", function()
  require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle GitSigns current line blame" })

vim.keymap.set("n", "<leader>uh", function()
  local ih = vim.lsp.inlay_hint or vim.lsp.buf.inlay_hint
  local bufnr = vim.api.nvim_get_current_buf()
  local enabled = ih.is_enabled({ bufnr = bufnr })
  ih.enable(not enabled, { bufnr = bufnr })
end, { desc = "Toggle Inlay Hints" })
