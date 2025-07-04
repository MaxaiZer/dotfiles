return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = function()
      require("neogit").setup({
        graph_view = true,
        integrations = {
          diffview = true,
        },
      })
    end,
    keys = {
      {
        "<leader>gg",
        ":Neogit<CR>",
        desc = "Open Neogit",
        mode = "n",
      },
    },
  },
}
