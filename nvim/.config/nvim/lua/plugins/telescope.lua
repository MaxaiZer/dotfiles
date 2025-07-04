return {
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        config = function()
          LazyVim.on_load("telescope.nvim", function()
            require("telescope").load_extension("live_grep_args")
          end)
        end,
      },
    },
    keys = {
      {
        "<leader>/",
        function()
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
        end,
        desc = "Live Grep",
        mode = "n",
      },
      {
        "<Space>r/",
        "<cmd>Telescope resume<cr>",
        desc = "Telescope resume",
        mode = "n",
      },
    },
  },
}
