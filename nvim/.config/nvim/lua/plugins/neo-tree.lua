return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        use_libuv_file_watcher = false,
      },
      default_component_configs = {
        git_status = {
          symbols = {
            unstaged = "",
            modified = "•",
          },
        },
      },
    },
  },
}
