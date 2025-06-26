vim.keymap.set("n", "<C-a>", "gg0vG$", { desc = "Select all" })
vim.keymap.set("n", "<C-q>", ":qa<CR>", { desc = "Quit all" })

vim.keymap.set("n", "<Space>/", function()
  require("telescope.builtin").live_grep({
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "bottom",
        results_width = 0.35,
        preview_width = 0.65,
      },
    },
  })
end, { desc = "Live Grep" })
