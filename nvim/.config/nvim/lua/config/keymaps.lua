vim.keymap.set("n", "<C-a>", "gg0vG$", { desc = "Select all" })
vim.keymap.set("n", "<C-q>", ":qa<CR>", { desc = "Quit all" })

vim.keymap.set("n", "<Space>/", function()
  require("telescope").extensions.live_grep_args.live_grep_args({
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
