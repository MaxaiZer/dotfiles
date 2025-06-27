return {
  { "grug-far.nvim", enabled = false },
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("spectre").setup({})

      vim.keymap.set("n", "<leader>sr", function()
        require("spectre").toggle()
      end, { desc = "Search + Replace" })

      vim.keymap.set("v", "<leader>sr", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
        desc = "Search current word + Replace",
      })
    end,
  },
}
