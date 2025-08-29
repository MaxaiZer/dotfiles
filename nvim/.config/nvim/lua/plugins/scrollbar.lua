return {
  "petertriho/nvim-scrollbar",
  opts = {
    handlers = {
      gitsigns = true,
      diagnostic = true,
      search = true,
      ale = false,
    },
    excluded_filetypes = {
      "neo-tree",
      "blink-cmp-menu",
      "dropbar_menu",
      "dropbar_menu_fzf",
      "DressingInput",
      "cmp_docs",
      "cmp_menu",
      "noice",
      "prompt",
      "TelescopePrompt",
    },
  },
}
