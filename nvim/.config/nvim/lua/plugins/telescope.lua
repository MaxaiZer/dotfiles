local live_grep_config = {
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
  attach_mappings = function(_, map)
    map("i", "<C-t>", function(bufnr)
      require("trouble.sources.telescope").open(bufnr)
    end)
    map("n", "<C-t>", function(bufnr)
      require("trouble.sources.telescope").open(bufnr)
    end)
    return true
  end,
}

return {
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      "folke/trouble.nvim",
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        config = function()
          LazyVim.on_load("telescope.nvim", function()
            require("telescope").load_extension("live_grep_args")
          end)
        end,
      },
    },
    config = function()
      require("telescope").load_extension("live_grep_args")

      vim.keymap.set("n", "<leader>/", function()
        require("telescope").extensions.live_grep_args.live_grep_args(live_grep_config)
      end, { desc = "Live Grep" })

      vim.keymap.set("n", "<leader>/p", function()
        local config = vim.tbl_deep_extend("force", live_grep_config, {
          default_text = vim.fn.getreg("+"):match("^[^\n\r]*"),
          additional_args = function()
            return { "-F" }
          end,
        })
        require("telescope").extensions.live_grep_args.live_grep_args(config)
      end, { desc = "Live Grep (clipboard)" })

      vim.keymap.set("n", "<leader>/r", "<cmd>Telescope resume<cr>", { desc = "Telescope resume" })
    end,
  },
}
